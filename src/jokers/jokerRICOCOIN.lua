SMODS.Joker {
    key = 'marksmancoin',
    atlas = 'jonklers',
    pos = { x = 1, y = 1 },
    to_number = to_number or function(x) return x end,
    config = { extra = { repetitions = 1, dollars = 10, odds = 2, } },
    rarity = 2,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'neonmod_joyconr')
        return { vars = { card.ability.extra.repetitions, card.ability.extra.dollars, card.ability.extra.repetitions * math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars), numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[1] then
            return {
                repetitions = to_number(card.ability.extra.repetitions *
                    math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars))
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'neonmod_marksmancoin', 1, card.ability.extra.odds) then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = 'Broken!'
                }
            end
        end
    end,
}
