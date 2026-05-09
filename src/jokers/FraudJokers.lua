SMODS.Joker {
    key = "fraudfirst",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = "jonklers",
    pos = { x = 4, y = 2 },
    config = { extra = { max = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max } }
    end,
    calculate = function(self, card, context)
        if context.before and #context.full_hand <= card.ability.extra.max and G.GAME.current_round.hands_played <= 0 and not context.blueprint then
            for i, scored_card in ipairs(context.scoring_hand) do
                if (scored_card:get_id() == 14 or scored_card:get_id() == 8) and scored_card.edition == nil then
                    --valid_id = true
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            local edition = SMODS.poll_edition { key = "hurtbreak_wonderland", guaranteed = true, no_negative = true } --, options = { 'e_polychrome', 'e_holo', 'e_foil' }
                            scored_card:set_edition(edition, true)
                            scored_card:juice_up(0.3, 0.5)
                            return true
                        end
                    }))
                end
            end
        end
    end
}
SMODS.Joker {
    key = "fraudsecond",
    blueprint_compat = true,
    rarity = 2,
    cost = 8,
    atlas = "jonklers",
    pos = { x = 5, y = 2 },
    calculate = function(self, card, context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.individual and context.cardarea == G.play and G.GAME.current_round.hands_played <= 0 and #context.full_hand == 1 then
            local valid_id = false
            for i = 1, #context.full_hand do
                if context.full_hand[i]:get_id() == 2 then
                    valid_id = true
                elseif context.full_hand[i]:get_id() == 8 then
                    valid_id = true
                end
            end
            if valid_id then
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local card_copied = copy_card(context.full_hand[1], nil, nil, G.playing_card)
                card_copied:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, card_copied)
                G.hand:emplace(card_copied)
                card_copied.states.visible = nil
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_copied:start_materialize()
                        return true
                    end
                }))
                return {
                    message = localize('k_copied_ex'),
                    colour = G.C.CHIPS,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                SMODS.calculate_context({ playing_card_added = true, cards = { card_copied } })
                                return true
                            end
                        }))
                    end
                }
            end
        end
    end
}
SMODS.Joker {
    key = "fraudthird",
    blueprint_compat = true,
    rarity = 3,
    cost = 8,
    atlas = "jonklers",
    pos = { x = 3, y = 2 },
    config = { extra = { odds = 3 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'fraudthird')
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if (context.other_card:get_id() == 8 or context.other_card:get_id() == 3) and SMODS.pseudorandom_probability(card, 'fraudthird', 1, card.ability.extra.odds) then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                return {
                    extra = {
                        message = '+1 Planet',
                        message_card = card,
                        func = function()
                            --G.E_MANAGER:add_event(Event({
                            --func = (function()
                            SMODS.add_card {
                                set = 'Planet',
                                edition = 'e_negative',
                                key_append = 'fraudthird'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                            --end)
                            --}))
                        end
                    },
                }
            end
        end
    end
}
SMODS.Joker {
    key = "fraudclimax",
    blueprint_compat = true,
    rarity = 3,
    cost = 8,
    atlas = "jonklers",
    pos = { x = 0, y = 3 },
    config = { extra = { xmult = 1, xmult_mod = 0.1, odds = 4 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'finalflight')
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_mod, numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and (context.other_card:get_id() == 8 or context.other_card:get_id() == 4) and not context.blueprint then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT,
                message_card = card
            }
        end
        if context.destroy_card then
            if context.cardarea == G.play and (context.destroy_card:get_id() == 8 or context.destroy_card:get_id() == 4) and SMODS.pseudorandom_probability(card, 'finalflight', 1, card.ability.extra.odds) then
                return { remove = true }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}
--[[SMODS.Joker {
    key = "sampletext",
    blueprint_compat = false,
    rarity = 2,
    cost = 7,
    atlas = "jonklers",
    pos = { x = 2, y = 3 },
    config = { extra = { max = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            for i, scored_card in ipairs(context.scoring_hand) do
                if (scored_card:get_id() == 14 or scored_card:get_id() == 8) and scored_card.edition == nil then
                    --valid_id = true
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            local edition = SMODS.poll_edition { key = "hurtbreak_wonderland", guaranteed = true, no_negative = true } --, options = { 'e_polychrome', 'e_holo', 'e_foil' }
                            scored_card:set_edition(edition, true)
                            scored_card:juice_up(0.3, 0.5)
                            return true
                        end
                    }))
                end
            end
        end
    end
}
--]]
