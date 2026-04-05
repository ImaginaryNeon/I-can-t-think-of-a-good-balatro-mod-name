SMODS.Joker {
    key = 'joyconl',
    atlas = 'jonklers',
    pos = {
        x = 4,
        y = 0
    },
    rarity = 2,
    cost = 6,
    config = {
        extra = {
            chips = 0,
            change = 5
        }
    },
    pixel_size = { w = 23, h = 47 },
    loc_vars = function(self, info_queue, card)
        do
            return {
                vars = {
                    card.ability.extra.chips,
                    card.ability.extra.change,
                },
            }
        end
        if card.area and card.area == G.jokers then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
        end
    end,
    calculate = function(self, card, context)
        local other_joker = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
        end
        if context.post_trigger and context.other_card == other_joker then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = 'chips',
                scalar_value = 'change',
                message_colour = G.C.ATTENTION
            })
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}
