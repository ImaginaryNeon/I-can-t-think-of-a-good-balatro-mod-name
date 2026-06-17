SMODS.Joker {
    key = "kingambit",
    rarity = 3,
    cost = 8,
    atlas = 'jonklers',
    blueprint_compat = true,
    pos = { x = 3, y = 1 },
    config = { extra = { xmult_gain = 0.25, xmult = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint and not context.retrigger_joker then
            local fallen_cards = 0
            for _, removed_card in ipairs(context.removed) do
                fallen_cards = fallen_cards + 1
            end
            if fallen_cards > 0 then
                -- See note about SMODS Scaling Manipulation on the wiki
                card.ability.extra.xmult = card.ability.extra.xmult + fallen_cards * card.ability.extra.xmult_gain
                return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } } }
            end
        end
        if context.joker_type_destroyed and not context.blueprint and not context.retrigger_joker then
            -- See note about SMODS Scaling Manipulation on the wiki
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
            return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } } }
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}

SMODS.Joker {
    key = "redbaron",
    atlas = 'jonklers',
    rarity = 3,
    cost = 5,
    blueprint_compat = true,
    pos = { x = 2, y = 2 },
    pixel_size = { w = 71, h = 71 },
    display_size = { w = 71 * 1.2, h = 71 * 1.2 },
    attributes = { 'xmult', 'scaling', 'economy', 'food' },
    config = { extra = { fee = 5, xmult_gain = 0.15, xmult = 1, total_spent = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.fee, card.ability.extra.xmult_gain, card.ability.extra.xmult, card.ability.extra.total_spent } }
    end,
    calculate = function(self, card, context)
        if context.ante_change and context.ante_end and not context.blueprint then
            if G.GAME.dollars >= 2 * card.ability.extra.fee then
                local numberofredbaronpizzastopurchase = math.floor(G.GAME.dollars / (2 * card.ability.extra.fee))
                card.ability.extra.xmult = card.ability.extra.xmult +
                    numberofredbaronpizzastopurchase * card.ability.extra.xmult_gain
                card.ability.extra.total_spent = card.ability.extra.total_spent +
                    numberofredbaronpizzastopurchase * card.ability.extra.fee
                return {
                    money = -(numberofredbaronpizzastopurchase * card.ability.extra.fee),
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}

SMODS.Joker {
    key = "dark_fountain",
    atlas = 'jonklers',
    rarity = 3,
    cost = 20,
    pos = { x = 1, y = 4 },
    blueprint_compat = false,
    config = { extra = { test = 2, total_mods = 1 } },
    attributes = { 'xblindsize', 'generation', 'joker' },
    loc_vars = function(self, info_queue, card)
        local modspool = {}
        local validmodcount = 0
        for k, v in pairs(G.P_CENTER_POOLS.Joker) do
            if v.mod and not next(SMODS.find_card(v.key)) then
                local found = false
                for k2, v2 in pairs(modspool) do
                    if v2 == v.mod.id then
                        found = true
                    end
                end
                if found == false then
                    table.insert(modspool, v.mod.id)
                    validmodcount = validmodcount + 1
                end
            end
        end
        card.ability.extra.test = validmodcount * 2
        card.ability.extra.total_mods = validmodcount
        return { vars = { validmodcount, card.ability.extra.test } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and context.blind.boss and not card.getting_sliced then
            local validmodcount = 0
            local modspool = {}
            for k, v in pairs(G.P_CENTER_POOLS.Joker) do
                if v.mod and not next(SMODS.find_card(v.key)) then
                    local found = false
                    for k2, v2 in pairs(modspool) do
                        if v2 == v.mod.id then
                            found = true
                        end
                    end
                    if found == false then
                        table.insert(modspool, v.mod.id)
                        validmodcount = validmodcount + 1
                    end
                end
            end
            card.ability.extra.test = validmodcount * 2
            card.ability.extra.total_mods = validmodcount
            G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.test
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            G.HUD_blind:recalculate()
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound("timpani")
                            delay(0.4)
                            return true
                        end,
                    }))
                    return true
                end,
            }))
        end
        if context.ante_change and context.ante_end and not context.blueprint then
            local modspool = {}
            local pooltocollect = {}
            local validmodcount = 0
            for k, v in pairs(G.P_CENTER_POOLS.Joker) do
                if v.mod and not next(SMODS.find_card(v.key)) then
                    local found = false
                    for k2, v2 in pairs(modspool) do
                        if v2 == v.mod.id then
                            found = true
                        end
                    end
                    if found == false then
                        table.insert(modspool, v.mod.id)
                        validmodcount = validmodcount + 1
                    end
                end
            end
            -- Get a random joker from each mod
            for k2, v2 in pairs(modspool) do
                local thismodlist = {}
                local thismodjkrcount = 0
                for i, d in pairs(G.P_CENTER_POOLS.Joker) do
                    if d.mod then
                        if d.mod.id == v2 and not next(SMODS.find_card(d.key)) then
                            table.insert(thismodlist, d.key)
                            thismodjkrcount = thismodjkrcount + 1
                        end
                    end
                end
                if thismodjkrcount > 0 then
                    local randed_joker_for_this_mod = pseudorandom_element(thismodlist,
                        "The Shattering Circle, or: A Charade of Shadeless Ones and Zeroes Rearranged ad Nihilum" ..
                        G.GAME.round_resets.ante)
                    SMODS.add_card { set = 'Joker', key = randed_joker_for_this_mod, edition = 'e_negative' }
                end
            end
            SMODS.destroy_cards(card, nil, nil, true)
        end
    end,
}
SMODS.Joker {
    key = 'scope',
    atlas = 'jonklers',
    pos = {
        x = 0,
        y = 5
    },
    rarity = 2,
    cost = 6,
    config = {
        extra = {
            xmult = 3,
        }
    },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, math.max(G.GAME.current_round.hands_left, 1),
            'neonmod_joyconr')
        return { vars = { card.ability.extra.xmult, numerator, denominator } }
    end,
    collection_loc_vars = function(self)
        return { vars = { card.ability.extra.xmult, 1, "[hands remaining]", "" } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if SMODS.pseudorandom_probability(card, 'neonmod_scopelens', 1, math.max((G.GAME.current_round.hands_left + 1), 1)) then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}
