SMODS.Joker {
    key = 'joyconr',
    atlas = 'jonklers',
    pos = {
        x = 5,
        y = 0
    },
    pixel_size = { w = 24, h = 47 },
    rarity = 2,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i + 1] == card then other_joker = G.jokers.cards[i] end
            end
        end
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'neonmod_joyconr')
        return { vars = { card.ability.extra.mult, card.ability.extra.change, numerator, denominator } }
    end,
    config = {
        extra = {
            mult = 0,
            change = 3,
            odds = 50,
        }
    },
    block_overrides = {
        value = true,  -- blocks modifications to the ref_value
        scalar = true, -- blocks modifications to the scalar_value
        message = true -- blocks modifications to the scaling_message
    },

    calculate = function(self, card, context)
        local other_joker = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i + 1] == card then other_joker = G.jokers.cards[i] end
        end
        if context.post_trigger and context.other_card == other_joker then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = 'mult',
                scalar_value = 'change',
                message_colour = G.C.ATTENTION
            })
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult

            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'neonmod_joyconr', 1, card.ability.extra.odds) then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = 'Broken!'
                }
            end
        end
    end
}
