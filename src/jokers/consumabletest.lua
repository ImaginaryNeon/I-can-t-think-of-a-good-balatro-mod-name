SMODS.Consumable {
    key = 'bighead',
    set = 'tarot',
    atlas = 'deck',
    pos = {
        x = 0,
        y = 0
    },
    select_card = 'consumeables',
    config = {
        extra = {
            xmult = 1.5,
            duration = 2,
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.duration
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult,
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.duration = card.ability.extra.duration - 1
            if card.ability.extra.duration <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
            end
        end
    end
    use = function(self, card, area, copier)
    end,
    can_use = function(self, card)
        return true
    end
}
