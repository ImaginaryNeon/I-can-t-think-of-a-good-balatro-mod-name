SMODS.Joker {
    key = "fraudthird",
    blueprint_compat = true,
    rarity = 3,
    cost = 8,
    atlas = "jonklers",
    pos = { x = 3, y = 2 },
    config = { extra = { odds = 5 } },
    loc_vars = function(self, info_queue, card)
        if not center.edition or (center.edition and not center.edition.negative) then
      			info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
    		end
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
                        func = function() -- This is for timing purposes, everything here runs after the message
                            G.E_MANAGER:add_event(Event({
                                func = (function()
                                    SMODS.add_card {
                                        set = 'Planet',
                                        edition = 'e_negative',
                                        key_append = 'fraudthird' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                                    }
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end)
                            }))
                        end
                    },
                }
            end
        end
    end
}
