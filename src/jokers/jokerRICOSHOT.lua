if Cryptid then
    SMODS.Joker {
        key = 'marksman',
        atlas = 'jonklers',
        pos = { x = 4, y = 1 },
        pixel_size = { w = 52, h = 95 },
        to_number = to_number or function(x) return x end,
        dependencies = {
            items = {
                "set_cry_epic",
            },
        },
        config = { extra = { repetitions = 1, dollars = 10 } },
        rarity = "cry_epic",
        cost = 7,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.repetitions,
                    card.ability.extra.dollars,
                    card.ability.extra.repetitions *
                    math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars)
                }
            }
        end,
        calculate = function(self, card, context)
            if context.repetition and context.cardarea == G.play then
                return {
                    repetitions = to_number(card.ability.extra.repetitions *
                        math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars))
                }
            end
        end,
    }
else
    SMODS.Joker {
        key = 'marksman',
        atlas = 'jonklers',
        pos = { x = 4, y = 1 },
        pixel_size = { w = 52, h = 95 },
        to_number = to_number or function(x) return x end,
        config = { extra = { repetitions = 1, dollars = 15 } },
        rarity = 3,
        cost = 8,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.repetitions,
                    card.ability.extra.dollars,
                    card.ability.extra.repetitions *
                    math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars)
                }
            }
        end,
        calculate = function(self, card, context)
            if context.repetition and context.cardarea == G.play then
                return {
                    repetitions = to_number(card.ability.extra.repetitions *
                        math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars))
                }
            end
        end,
    }
end
SMODS.Joker {
    key = 'marksmancoin',
    atlas = 'jonklers',
    pos = { x = 1, y = 1 },
    to_number = to_number or function(x) return x end,
    config = { extra = { repetitions = 1, dollars = 12, odds = 3, } },
    rarity = 2,
    cost = 6,
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
