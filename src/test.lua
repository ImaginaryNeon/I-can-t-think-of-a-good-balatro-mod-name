--[[
SMODS.Joker {
    key = 'rorrim', -- Rorrim Joker
    rarity = 3,
    abn_coder = "ImaginaryNeon",
    atlas = 'ABNJokerSheet15',
    pos = { x = 6, y = 5 },
    --atlas = 'jonklers',     -- test sprites from my own mod
    --pos = { x = 4, y = 4 }, -- Hideous Mass
    cost = 8,
    discovered = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = { extra = { mult_per = 1, chips_per = 2 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return { vars = { card.ability.extra.mult_per, card.ability.extra.chips_per } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, "m_glass") then
                local count = 0
                for _, scored_card in ipairs(context.scoring_hand) do
                    if not SMODS.has_enhancement(scored_card, "m_glass") then
                        count = count + 1
                        scored_card.ability.perma_bonus = (scored_card.ability.perma_bonus or 0) +
                            (card.ability.extra.chips_per * #context.scoring_hand)
                        scored_card.ability.perma_mult = (scored_card.ability.perma_mult or 0) +
                            (card.ability.extra.mult_per * #context.scoring_hand)
                    end
                end
                if count > 0 then
                    return {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.RED
                    }
                end
            end
        end
        if context.remove_playing_cards and not context.blueprint then
            local glass_cards = 0
            for _, removed_card in ipairs(context.removed) do
                if removed_card.shattered and SMODS.has_enhancement(removed_card, "m_glass") then
                    glass_cards = glass_cards + 1
                    if context.scoring_hand then
                        for _, scored_card in ipairs(context.scoring_hand) do
                            if not SMODS.has_enhancement(scored_card, "m_glass") then
                                scored_card.ability.perma_bonus = scored_card:get_chip_bonus()
                            end
                        end
                    end
                end
            end
            if glass_cards > 0 then
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.RED
                }
            end
        end
    end,
    in_pool = function(self, args) --equivalent to `enhancement_gate = 'm_steel'`
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_glass') then
                return true
            end
        end
        return false
    end,
    abn_artist_credits = {
        artist = "Triangle Snack",
    }
}
]]

SMODS.Joker {
    key = 'spellcheck', -- Spell Check
    rarity = 1,
    abn_coder = "ImaginaryNeon",
    --atlas = 'ABNJokerSheet27',
    --pos = { x = 5, y = 1 },
    atlas = 'jonklers',     -- test sprites from my own mod
    pos = { x = 0, y = 2 }, -- Hideous Mass
    cost = 6,
    discovered = false,
    blueprint_compat = true,
    demicoloncompat = false,
    config = { extra = { chips = 0, mult = 0, chip_gain = 10, mult_gain = 4, jokertextEN = "Joker", jestertextEN = "Jester", jokertextRU = "Russian for Joker", jestertextRU = "Russian for Jester" } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.chip_gain, card.ability.extra.mult_gain } }
    end,
    calculate = function(self, card, context)
        --
        if context.post_trigger and not context.blueprint then
            card.ability.extra.other_key = context.other_card.config.center.key
            local obj_key = context.other_card.config.center.key
            local obj_set = context.other_card.ability.set
            local tarname = localize { type = 'name_text', set = obj_set, key = obj_key }
            if tarname:find(card.ability.extra.jokertextEN) or tarname:find(card.ability.extra.jokertextRU) then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = 'chips',
                    scalar_value = 'chip_gain',
                    message_colour = G.C.ATTENTION
                })
            end
            if tarname:find(card.ability.extra.jestertextEN) or tarname:find(card.ability.extra.jestertextRU) then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = 'mult',
                    scalar_value = 'mult_gain',
                    message_colour = G.C.ATTENTION
                })
            end
        end
        if context.joker_main or context.forcetrigger then
            if card.ability.extra.mult > 0 or card.ability.extra.chips > 0 then
                return {
                    chips = card.ability.extra.chips,
                    mult = card.ability.extra.mult
                }
            end
        end
    end,
    abn_artist_credits = {
        artist = "Gamer9Ts",
    }
}

SMODS.Joker { -- Hands start with 999 Chips and 99 Mult, unless current Chips/Mult is greater
    key = "blue_jewel",
    rarity = 3,
    abn_coder = "ImaginaryNeon",
    --atlas = 'ABNJokerSheet27',
    --pos = { x = 5, y = 1 },
    atlas = 'jonklers',     -- test sprites from my own mod
    pos = { x = 0, y = 2 }, -- Hideous Mass
    cost = 6,
    discovered = false,
    blueprint_compat = true,
    demicoloncompat = false,
    attributes = { 'joker' },
    config = {
        extra = {
            xchips = 2,
        },
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips } }
    end,
    calculate = function(self, card, context)
        if context.modify_hand and not context.blueprint then
            --mult = mod_mult(mult)
            hand_chips = mod_chips(hand_chips * card.ability.extra.xchips)
            update_hand_text({ sound = 'chips2', modded = true }, { chips = hand_chips, --[[mult = mult--]] })
        end
    end,
    abn_artist_credits = {
        artist = "Technotoad64",
    }
}

--[[SMODS.Joker {
    key = 'cracked', -- Cracked Joker
    rarity = 3,
    abn_coder = "ImaginaryNeon",
    atlas = 'ABNJokerSheet15',
    pos = { x = 6, y = 5 },
    --atlas = 'jonklers',     -- test sprites from my own mod
    --pos = { x = 4, y = 4 }, -- Hideous Mass
    cost = 6,
    discovered = false,
    blueprint_compat = true,
    demicoloncompat = false,
    config = { extra = { odds = 4 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'neonmod_cracked')
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.fix_probability and context.trigger_obj == G.play then
            if context.identifier == '' then
                return {
                    numerator = context.denominator
                }
            end
        end
        if context.remove_playing_cards and not context.blueprint then
            local glass_cards = 0
            for _, removed_card in ipairs(context.removed) do
                if removed_card.shattered and SMODS.has_enhancement(removed_card, "m_glass") then
                    glass_cards = glass_cards + 1
                    if context.scoring_hand then
                        for _, scored_card in ipairs(context.scoring_hand) do
                            if not SMODS.has_enhancement(scored_card, "m_glass") then
                                scored_card.ability.perma_bonus = scored_card:get_chip_bonus()
                            end
                        end
                    end
                end
            end
            if glass_cards > 0 then
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.RED
                }
            end
        end
    end,
    in_pool = function(self, args) --equivalent to `enhancement_gate = 'm_steel'`
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_glass') then
                return true
            end
        end
        return false
    end,
    abn_artist_credits = {
        artist = "Triangle Snack",
    }
}--]]

--[[
SMODS.Joker {
    key = 'mult_to_chips', -- Bonus Bradly
    rarity = 2,
    abn_coder = "ImaginaryNeon",
    atlas = 'ABNJokerSheet23',
    pos = { x = 1, y = 0 },
    --atlas = 'jonklers', -- test sprites from my own mod
    --pos = { x = 5, y = 4 }, -- Cheat Code
    cost = 6,
    discovered = false,
    blueprint_compat = false,
    demicoloncompat = false,
    config = { extra = { chips = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.post_trigger and not context.blueprint then
            local other_ret = context.other_ret.jokers or {}
            if other_ret.mult then
                return {
                    chips = tonumber(other_ret.mult),
                    message_card = card,
                }
            end
        end
    end,
    abn_artist_credits = {
        artist = "GM36",
    }
}--]]
