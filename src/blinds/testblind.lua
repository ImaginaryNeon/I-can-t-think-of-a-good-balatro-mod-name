SMODS.Blind {
    key = 'fleshprison',
    atlas = 'animblinds',
    pos = {
        y = 0
    },
    config = {
        extra = {
            xmult = 0.9,
        },
    },
    boss = { min = 2 },
    boss_colour = HEX('701814'),
    loc_vars = function(self)
        return { vars = { self.config.extra.xmult } }
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.post_trigger and not (context.other_card.ability == nil) then
                if context.other_card.ability.set == "Joker" then
                    return {
                        xmult = blind.effect.extra.xmult,
                        message = 'Decayed!',
                        card = context.blueprint_card or context.other_card or blind,
                    }
                end
            end
            --[[if context.cardarea == G.play and context.main_scoring then
                return {
                    xmult = blind.effect.extra.xmult,
                    message = 'Decayed!',
                }
            end--]]
        end
    end
}

--[[local letter = string.sub(G.PROFILES[G.SETTINGS.profile].name, 1, 1)
local yvalue = letter
for i = 1, 10, 2 do
  print(i)
end]]

SMODS.Blind {
    key = 'personalizedblind',
    atlas = 'personalized',
    pos = {
        y = 1
    },
    config = { extra = { hands = {} } },
    dollars = 5,
    mult = 2,
    boss = { min = 3 },
    boss_colour = HEX("b9cb92"),
    calculate = function(self, blind, context)
        if blind.disabled then return end
        --[[        if context.setting_blind then
            blind.effect.extra.hands = {}
            for _, poker_hand in ipairs(G.handlist) do
                blind.effect.extra.hands[poker_hand] = false
            end
            local currenthands = {}
            local currentcount = 0
            for i, poker_hand in ipairs(G.handlist) do
                if G.PROFILES[G.SETTINGS.profile].hand_usage[poker_hand] then
                    if (G.PROFILES[G.SETTINGS.profile].hand_usage[poker_hand].count > currentcount) then
                        currenthands = { poker_hand }
                        currentcount = G.PROFILES[G.SETTINGS.profile].hand_usage[poker_hand].count
                    elseif G.PROFILES[G.SETTINGS.profile].hand_usage[poker_hand].count == currentcount then
                        table.insert(currenthands, G.PROFILES[G.SETTINGS.profile].hand_usage[poker_hand].count)
                    end
                end
            end
            for i, v in pairs(currenthands) do
                blind.effect.extra.hands[v] = true
            end
        end ]] -- old code
        if context.debuff_hand then
            if context.scoring_name == G.GAME.current_round.neonmod_bighandthing then
                blind.triggered = true
                return {
                    debuff = true
                }
            end
        end
    end,
}

SMODS.Blind {
    key = 'metablind',
    atlas = 'personalized',
    pos = {
        y = 0
    },
    dollars = 5,
    mult = 2,
    boss = { min = 4, max = 12 },
    config = { extra = { jokerbans = {} } },
    boss_colour = G.C.DARK_EDITION, -- HEX("263b64"),
    calculate = function(self, blind, context)
        if blind.disabled then return end
        --[[        if context.setting_blind then
            local currentbans = {}
            local microban = nil
            local currentcount = 0
            G.GAME.neonmod_jokerbans = {}
            for i = 1, 15 do
                currentcount = 0
                for _, v in pairs(G.P_CENTER_POOLS.Joker) do
                    v.neonmod_jokerbans = false
                    if G.PROFILES[G.SETTINGS.profile].joker_usage[v] then
                        local found = false
                        for _, v2 in pairs(currentbans) do
                            if v2 == v.key then
                                found = true
                            end
                        end
                        if found == false then
                            if (G.PROFILES[G.SETTINGS.profile].joker_usage[v].count > currentcount) then
                                microban = v.key
                                currentcount = G.PROFILES[G.SETTINGS.profile].joker_usage[v].count
                            end
                        end
                    end
                end
                table.insert(currentbans, microban)
            end
            for _, v in pairs(currentbans) do
                v.neonmod_jokerbans = true
            end
        end]]
        if context.debuff_card and context.debuff_card.area == G.jokers then
            if (G.PROFILES[G.SETTINGS.profile].joker_usage[context.debuff_card.config.center.key].count or 0) >= (G.GAME.current_round.neonmod_min_uses or 1) then
                return {
                    debuff = true
                }
            end
        end
    end,
}

SMODS.Blind {
    key = 'earthmover',
    atlas = 'animblinds',
    pos = {
        y = 1
    },
    dollars = 5,
    mult = 2,
    boss = { min = 7 },
    boss_colour = HEX("4e586b"),
    calculate = function(self, blind, context)
        if blind.disabled then return end
        if context.modify_hand then
            blind.triggered = true -- This won't trigger Matador in this context due to a Vanilla bug (a workaround is setting it in context.debuff_hand)
            local flush_chips = G.GAME.hands["Flush"].chips
            local flush_mult = G.GAME.hands["Flush"].mult
            mult = mod_mult(math.max(math.floor(mult - flush_mult), 0))
            hand_chips = mod_chips(math.max(math.floor(hand_chips - flush_chips), 0))
            update_hand_text({ sound = 'chips2', modded = true }, { chips = hand_chips, mult = mult })
        end
    end
} --]]


SMODS.Blind {
    key = 'rorynyte',
    atlas = 'animblinds',
    pos = {
        y = 2
    },
    dollars = 5,
    mult = 2,
    boss = { min = 3 },
    boss_colour = HEX("303840"),

    calculate = function(self, blind, context)
        if blind.disabled then return end
        if context.end_of_round and context.game_over == false and context.main_eval then
            for i = 1, #G.hand.cards do
                --if SMODS.pseudorandom_probability(card, 'cherrybomb_odds', 1, card.ability.extra.odds) then
                SMODS.destroy_cards(G.hand.cards[i])
                --end
            end
        end
    end
} --]]

SMODS.Blind {
    key = 'whenthe',
    atlas = 'animblinds',
    pos = {
        y = 3
    },
    config = {
        extra = { odds = 3 }
    },
    dollars = 5,
    mult = 1.72,
    loc_vars = function(self)
        local numerator, denominator = SMODS.get_probability_vars(self, 1, 3, 'neonmod_pichu')
        return { vars = { numerator, denominator } }
    end,
    collection_loc_vars = function(self)
        return { vars = { '1', '3' } }
    end,
    boss = { min = 2 },
    boss_colour = HEX('ffef5c'),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.post_trigger and not (context.other_card.ability == nil) then
                if context.other_card.ability.set == "Joker" then
                    if SMODS.pseudorandom_probability(blind, 'neonmod_pichu', 1, 3) then
                        return {
                            dollars = -1,
                            card = context.blueprint_card or context.other_card or blind,
                        }
                    end
                end
            end
        end
    end
}

SMODS.Blind {
    key = 'radio',
    atlas = 'animblinds',
    pos = {
        y = 4
    },
    dollars = 5,
    mult = 2,
    boss = { min = 3 },
    boss_colour = HEX('3bcced'),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card then
                local rank = context.debuff_card:get_id() -- context.debuff_card is itself a card object being checked to see if it should be debuffed
                if rank == 2 or rank == 5 or rank == 8 then
                    return { debuff = true }
                end
            end
        end
    end,
}

SMODS.Blind {
    key = 'ytp', -- code for replicating individual blinds sourced from VanillaRemade
    atlas = 'animblinds',
    pos = {
        y = 5
    },
    config = {
        extra = {
            list = { "Hook", "Ox", "Wheel", "Arm", "Club", "Fish", "Psychic", "Goad", "Water", "Window", "Manacle", "Eye", "Plant", "Serpent", "Pillar", "Head", "Tooth", "Flint", "Mark" },
            selection = "none", discards_sub = 0, size_sub = 0, hands = {},
        }
    },
    dollars = 5,
    mult = 2,
    boss = { min = 4 },
    boss_colour = HEX('3bcced'),
    modifies_draw = true,
    loc_vars = function(self)
        local config = G.GAME.blind.effect.extra or self.config.extra
        return { vars = { (config.selection or "None") } }
    end,
    calculate = function(self, blind, context)
        if context.press_play and not blind.disabled then
            blind.prepped = true
        end
        if context.hand_drawn then -- Rand logic, plus Water, Manacle
            if blind.prepped then
                local prioritem = blind.effect.extra.selection
                local itemlist = {}
                for i = 1, #blind.effect.extra.list do
                    if not (blind.effect.extra.list[i] == prioritem) then
                        table.insert(itemlist, blind.effect.extra.list[i])
                    end
                end
                blind.effect.extra.selection = pseudorandom_element(itemlist,
                    "neonmod_ytpselect" .. G.GAME.round_resets.ante)
                for k, v in pairs(G.playing_cards) do
                    SMODS.recalc_debuff(v)
                end
                if blind.effect.extra.selection == "Water" then
                    blind.effect.extra.discards_sub = G.GAME.current_round.discards_left
                    ease_discard(-blind.effect.extra.discards_sub)
                else
                    if blind.effect.extra.discards_sub > 0 then
                        ease_discard(blind.effect.extra.discards_sub)
                        blind.effect.extra.discards_sub = 0
                    end
                end
                if blind.effect.extra.selection == "Manacle" then
                    blind.effect.extra.size_sub = blind.effect.extra.size_sub + 1
                    G.hand:change_size(-1)
                else
                    if blind.effect.extra.size_sub > 0 then
                        G.hand:change_size(blind.effect.extra.size_sub)
                        blind.effect.extra.size_sub = 0
                    end
                end
            end
            blind:set_text()
        end
        if context.blind_disabled or context.blind_defeated then
            if blind.effect.extra.discards_sub > 0 then
                ease_discard(blind.effect.extra.discards_sub)
                blind.effect.extra.discards_sub = 0
            end
            if blind.effect.extra.size_sub > 0 then
                G.hand:change_size(blind.effect.extra.size_sub)
                blind.effect.extra.size_sub = 0
            end
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].facing == 'back' then
                    G.hand.cards[i]:flip()
                end
            end
            for _, playing_card in pairs(G.playing_cards) do
                playing_card.ability.wheel_flipped = nil
            end
            blind.effect.extra.hands = {}
            for _, poker_hand in ipairs(G.handlist) do
                blind.effect.extra.hands[poker_hand] = false
            end
            blind.effect.extra.selection = "None"
        end

        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand then -- Wheel, Fish, Mark
                if (blind.effect.extra.selection == "Wheel" and SMODS.pseudorandom_probability(blind, 'vremade_wheel', 1, 7))
                    or (blind.effect.extra.selection == "Fish" and blind.prepped)
                    or (blind.effect.extra.selection == "Mark" and context.other_card:is_face(true)) then
                    return { stay_flipped = true }
                end
            end
            if context.debuff_hand then -- Arm, Psychic, Eye, Flint, Ox
                blind.triggered = false
                if blind.effect.extra.selection == "Arm" and G.GAME.hands[context.scoring_name].level > 1 then
                    blind.triggered = true
                    if not context.check then
                        return {
                            level_up = -1
                        }
                    end
                end
                if blind.effect.extra.selection == "Psychic" and #context.full_hand ~= 5 then
                    blind.triggered = true
                    return {
                        debuff = true,
                        debuff_text = "Current Blind: The Psychic"
                    }
                end
                if blind.effect.extra.selection == "Eye" and blind.effect.extra.hands[context.scoring_name] then
                    blind.triggered = true
                    return {
                        debuff = true,
                        debuff_text = "Current Blind: The Eye"
                    }
                end
                if blind.effect.extra.selection == "Ox" and context.scoring_name == G.GAME.current_round.most_played_poker_hand then
                    blind.triggered = true
                    if not context.check then
                        return {
                            dollars = -G.GAME.dollars,
                            instant = true,
                            func = function()
                                blind:wiggle()
                            end
                        }
                    end
                end
                if not context.check then
                    blind.effect.extra.hands[context.scoring_name] = true
                end
            end
            if context.press_play then -- Hook, Tooth
                if blind.effect.extra.selection == "Hook" then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local any_selected = nil
                            local _cards = {}
                            for _, playing_card in ipairs(G.hand.cards) do
                                _cards[#_cards + 1] = playing_card
                            end
                            for i = 1, 2 do
                                if G.hand.cards[i] then
                                    local selected_card, card_index = pseudorandom_element(_cards, 'vremade_hook')
                                    G.hand:add_to_highlighted(selected_card, true)
                                    table.remove(_cards, card_index)
                                    any_selected = true
                                    play_sound('card1', 1)
                                end
                            end
                            if any_selected then G.FUNCS.discard_cards_from_highlighted(nil, true) end
                            return true
                        end
                    }))
                    blind.triggered = true
                    delay(0.7)
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = (function()
                            SMODS.juice_up_blind()
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.06 * G.SETTINGS.GAMESPEED,
                                blockable = false,
                                blocking = false,
                                func = function()
                                    play_sound('tarot2', 0.76, 0.4); return true
                                end
                            }))
                            play_sound('tarot2', 1, 0.4)
                            return true
                        end)
                    }))
                    delay(0.4)
                end
                if blind.effect.extra.selection == "Tooth" then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function()
                            for i = 1, #G.play.cards do
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        G.play.cards[i]:juice_up()
                                        return true
                                    end,
                                }))
                                ease_dollars(-1)
                                delay(0.23)
                            end
                            return true
                        end
                    }))
                    blind.triggered = true -- This won't trigger Matador in this context due to a Vanilla bug (a workaround is setting it in context.debuff_hand)
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = (function()
                            SMODS.juice_up_blind()
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.06 * G.SETTINGS.GAMESPEED,
                                blockable = false,
                                blocking = false,
                                func = function()
                                    play_sound('tarot2', 0.76, 0.4)
                                    return true
                                end
                            }))
                            play_sound('tarot2', 1, 0.4)
                            return true
                        end)
                    }))
                    delay(0.4)
                end
            end
            if context.debuff_card and context.debuff_card.area ~= G.jokers then -- Head, Goad, Window, Club, Plant, Pillar
                local item_1 = blind.effect.extra.selection
                if context.debuff_card:is_suit("Hearts", true) and item_1 == "Head" then
                    return { debuff = true }
                end
                if context.debuff_card:is_suit("Spades", true) and item_1 == "Goad" then
                    return { debuff = true }
                end
                if context.debuff_card:is_suit("Diamonds", true) and item_1 == "Window" then
                    return { debuff = true }
                end
                if context.debuff_card:is_suit("Clubs", true) and item_1 == "Club" then
                    return { debuff = true }
                end
                if context.debuff_card:is_face(true) and item_1 == "Plant" then
                    return { debuff = true }
                end
                if context.debuff_card.ability.played_this_ante and item_1 == "Pillar" then
                    return { debuff = true }
                end
            end
            if blind.effect.extra.selection == "Serpent" and context.drawing_cards and (G.GAME.current_round.hands_played ~= 0 or G.GAME.current_round.discards_used ~= 0) then
                return {
                    cards_to_draw = 3
                }
            end
            if blind.effect.extra.selection == "Flint" and context.modify_hand then
                blind.triggered = true -- This won't trigger Matador in this context due to a Vanilla bug (a workaround is setting it in context.debuff_hand)
                mult = mod_mult(math.max(math.floor(mult * 0.5 + 0.5), 1))
                hand_chips = mod_chips(math.max(math.floor(hand_chips * 0.5 + 0.5), 0))
                update_hand_text({ sound = 'chips2', modded = true }, { chips = hand_chips, mult = mult })
            end
        end
    end,
}
