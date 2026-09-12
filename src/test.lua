--[[SMODS.Joker {
    key = 'spihcneve', -- what the hell is a 'Spihcneve' even supposed to be? ...oh wait it's "even chips" backwards okay`
    rarity = 3,
    abn_coder = "ImaginaryNeon",
    --atlas = 'ABNJokerSheet11',
    --pos = { x = 9, y = 5 },
    atlas = 'jonklers',     -- test sprites from my own mod
    pos = { x = 0, y = 0 }, -- Chair
    cost = 8,
    discovered = false,
    --unlocked = false,
    blueprint_compat = true,
    demicoloncompat = false,
    config = { extra = { chip_gain = 40, mult_gain = 10 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
        return { vars = { card.ability.extra.chip_gain, card.ability.extra.mult_gain } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, "m_mult") then
                if ABN.is_even(context.other_card) then
                    for _, scored_card in ipairs(context.scoring_hand) do
                        if ABN.is_odd(scored_card) and not SMODS.has_enhancement(scored_card, "m_mult") then
                            count = count + 1
                            scored_card.ability.perma_mult = (scored_card.ability.perma_mult or 0) +
                                card.ability.extra.mult_gain
                        end
                    end
                end
                local count = 0
                for _, scored_card in ipairs(context.scoring_hand) do
                    if not SMODS.has_enhancement(scored_card, "m_mult") then
                        count = count + 1
                        scored_card.ability.perma_bonus = (scored_card.ability.perma_bonus or 0) +
                            card.ability.extra.chip_gain
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                scored_card:juice_up()
                                return true
                            end
                        }))
                    end
                end
                if count > 0 then
                    return {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.CHIPS
                    }
                end
            end
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_mult') and ABN.is_even(playing_card) then
                return true
            end
        end
        return false
    end,
    abn_artist_credits = {
        artist = "Inky",
    }
}--]]

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


SMODS.Joker {
    key = 'cracked', -- Rorrim Joker
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
