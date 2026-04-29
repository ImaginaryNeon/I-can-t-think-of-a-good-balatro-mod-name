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
