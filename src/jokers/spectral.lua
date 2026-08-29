SMODS.Consumable {
    key = 'increment',
    set = 'Spectral',
    atlas = 'spectral',
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            rate = 1,
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.rate, G.GAME.spectral_rate or 0
            }
        }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.spectral_rate = (G.GAME.spectral_rate or 0) + card.ability.extra.rate
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return true
    end,
}

SMODS.Consumable {
    key = 'vault',
    set = 'Spectral',
    atlas = 'spectral',
    pos = { x = 1, y = 0 },
    soul_set = 'Spectral',
    soul_rate = 0.05,
    use = function(self, card, area, copier)
        local cards = SMODS.get_highlighted_cards({ G.jokers }, card, 1, 1, function(card)
            return card.ability.set == "Joker"
        end)
        local jkr = cards[1]
        if jkr.ability.extra.unbound then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.15,
                func = function()
                    jkr:flip()
                    if jkr.ability.extra.unbound then
                        jkr:set_ability(jkr.ability.extra.unbound)
                    end
                    play_sound("card1", percent)
                    jkr:juice_up(0.3, 0.3)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.15,
                func = function()
                    play_sound("card1", 0.9)
                    jkr:flip()
                    return true
                end,
            }))
        end
    end,
    can_use = function(self, card)
        local cards = SMODS.get_highlighted_cards({ G.jokers }, card, 1, 1, function(card)
            return (card.ability.set == "Joker" and card.ability.extra.unbound)
        end)
        return #cards == 1
    end,
    in_pool = function(self, card)
        --[[for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.extra.unbound then
                return true
            end
        end--]]
        if next(SMODS.find_card("j_neonmod_flowery")) or next(SMODS.find_card("j_neonmod_marksman")) or next(SMODS.find_card("j_neonmod_redtape")) then
            return true
        end
    end,
}
