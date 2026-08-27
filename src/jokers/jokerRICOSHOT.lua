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
        config = { extra = { repetitions = 1, dollars = 12, fee = 1.5 } },
        rarity = "cry_epic",
        cost = 12,
        blueprint_compat = true,
        demicoloncompat = false,
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
        blueprint_compat = true,
        demicoloncompat = false,
        config = { extra = { repetitions = 1, dollars = 12, fee = 2, unbound = "j_neonmod_marksmanunbound", } },
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
                    "first"
                }
            }
        end,
        calculate = function(self, card, context)
            if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[1] and (to_number(card.ability.extra.repetitions *
                    math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars))) > 0 then
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - (to_number(card.ability.extra.fee))
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
end
SMODS.Joker {
    key = "marksmanunbound",
    atlas = 'jonklers',
    no_collection = true,
    blueprint_compat = true,
    demicoloncompat = true,
    rarity = "neonmod_unbound",
    cost = 10,
    weight = 0,
    pos = { x = 4, y = 1 },
    pixel_size = { w = 52, h = 95 },
    to_number = to_number or function(x) return x end,
    config = { extra = { repetitions = 1, dollars = 15 } },
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
        if context.repetition and context.cardarea == G.play and (to_number(card.ability.extra.repetitions *
                math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars))) > 0 then
            return {
                repetitions = to_number(card.ability.extra.repetitions *
                    math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars))
            }
        end
    end,
}
SMODS.Joker {
    key = 'marksmancoin',
    atlas = 'jonklers',
    pos = { x = 1, y = 1 },
    to_number = to_number or function(x) return x end,
    config = { extra = { repetitions = 1, dollars = 10, odds = 3, } },
    rarity = 2,
    cost = 7,
    eternal_compat = false,
    blueprint_compat = true,
    demicoloncompat = false,
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
    demicoloncompat = true,
    pos = { x = 1, y = 5 },
    config = { extra = { mult = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult * (#love.audio.getRecordingDevices() or 0) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                mult = card.ability.extra.mult * (G.GAME.neonmod_devicecount or 0)
            }
        end
    end,
}
