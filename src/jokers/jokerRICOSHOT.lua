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
        config = { extra = { repetitions = 1, dollars = 15, fee = 1.5 } },
        rarity = "cry_epic",
        cost = 10,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.repetitions,
                    card.ability.extra.dollars,
                    card.ability.extra.repetitions *
                    math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars),
                    card.ability.extra.fee,
                    "last"
                }
            }
        end,
        calculate = function(self, card, context)
            if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[#context.scoring_hand] and (to_number(card.ability.extra.repetitions *
                    math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars))) > 0 then
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) -
                    (to_number(card.ability.extra.fee * (card.ability.extra.repetitions *
                        math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars))))
                return {
                    dollars = -card.ability.extra.fee,
                    func = function() -- This is for timing purposes, this goes after the dollar modification
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.dollar_buffer = 0
                                return true
                            end
                        }))
                    end,
                    repetitions = to_number(card.ability.extra.repetitions *
                        math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars)),
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
        config = { extra = { repetitions = 1, dollars = 15, fee = 2 } },
        rarity = 3,
        cost = 10,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.repetitions,
                    card.ability.extra.dollars,
                    card.ability.extra.repetitions *
                    math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars),
                    card.ability.extra.fee,
                    "the first scored card"
                }
            }
        end,
        calculate = function(self, card, context)
            if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[1] and (to_number(card.ability.extra.repetitions *
                    math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars))) > 0 then
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) -
                    (to_number(card.ability.extra.fee * (card.ability.extra.repetitions *
                        math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars))))
                return {
                    dollars = -(to_number(card.ability.extra.fee * (card.ability.extra.repetitions *
                        math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars)))),
                    func = function() -- This is for timing purposes, this goes after the dollar modification
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.dollar_buffer = 0
                                return true
                            end
                        }))
                    end,
                    repetitions = to_number(card.ability.extra.repetitions *
                        math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars)),
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
    config = { extra = { repetitions = 1, dollars = 10, odds = 3, } },
    rarity = 2,
    cost = 8,
    eternal_compat = false,
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'neonmod_marksmancoin')
        return { vars = { card.ability.extra.repetitions, card.ability.extra.dollars, card.ability.extra.repetitions * math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars), numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[1] and (to_number(card.ability.extra.repetitions *
                math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars))) > 0 then
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
SMODS.Joker {
    key = 'mike',
    atlas = 'jonklers',
    rarity = 1,
    cost = 1,
    pos = { x = 1, y = 5 },
    config = { extra = { mult = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult * (#love.audio.getRecordingDevices() or 0) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult * (G.GAME.neonmod_devicecount or 0)
            }
        end
    end,
}
