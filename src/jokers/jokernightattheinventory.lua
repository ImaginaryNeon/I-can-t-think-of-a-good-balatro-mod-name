SMODS.Joker {
    key = 'licensetomaim',
    atlas = 'jonklers',
    pos = { x = 2, y = 0 },
    config = { extra = { odds = 3 } },
    rarity = 2,
    cost = 6,
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

SMODS.Joker {
    key = 'dangeresque',
    atlas = 'jonklers',
    pos = { x = 2, y = 1 },
    config = { extra = { odds = 3, dollars = 100 } },
    rarity = 2,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'neonmod_dangeresque')
        return { vars = { card.ability.extra.dollars, numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.selling_self and G.GAME.blind.boss then
            if SMODS.pseudorandom_probability(card, 'neonmod_dangeresque', 1, card.ability.extra.odds) then
                return {
                    dollars = card.ability.extra.dollars,
                }
            else
                return {
                    message = 'Nope!'
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'ironcurtain',
    atlas = 'jonklers',
    pos = { x = 2, y = 4 },
    soul_pos = { x = 3, y = 4 },
    config = { extra = { xmult = 1.4, ammo = 20 } },
    rarity = 2,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.ammo } }
    end,
    calculate = function(self, card, context)
        if context.selling_card and context.card.ability.set == 'Joker' and not context.blueprint then
            card.ability.extra.ammo = card.ability.extra.ammo + context.card.sell_cost
            return {
                message = localize('k_upgrade_ex')
            }
        end
        if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            card.ability.extra.ammo = card.ability.extra.ammo - 1
            if card.ability.extra.ammo >= 0 then
                return { xmult = card.ability.extra.xmult }
            else
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = 'Out of ammo!'
                }
            end
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.ammo <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = 'Out of ammo!'
                }
            end
        end
    end,
}
