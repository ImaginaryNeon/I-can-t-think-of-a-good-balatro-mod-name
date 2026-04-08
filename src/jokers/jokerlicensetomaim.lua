SMODS.Joker {
    key = 'licensetomaim',
    atlas = 'jonklers',
    pos = { x = 2, y = 0 },
    config = { extra = { odds = 4 } },
    rarity = 3,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'neonmod_licensetomaim')
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and context.blind.boss then
            if SMODS.pseudorandom_probability(card, 'neonmod_licensetomaim', 1, card.ability.extra.odds) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.blind:disable()
                                play_sound('timpani')
                                delay(0.4)
                                return true
                            end
                        }
                        ))
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.blind:disable()
                                play_sound('timpani')
                                delay(0.4)
                                return true
                            end
                        }
                        ))
                        SMODS.calculate_effect({ message = 'Boss Inverted!' }, card)
                        return true
                    end
                }))
                return nil, true -- This is for Joker retrigger purposes
            end
        end
    end,
}
