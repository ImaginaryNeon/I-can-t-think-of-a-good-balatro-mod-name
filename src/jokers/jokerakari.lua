SMODS.Joker {
    key = "akari",
    rarity = 1,
    cost = 5,
    atlas = 'jonklers',
    blueprint_compat = true,
    pos = { x = 3, y = 6 },
    attributes = { 'chips', 'suit', 'diamonds', 'hearts' },
    pixel_size = { w = 66, h = 90 },
    config = { extra = { mult = 0, mult_gain = 3, chips = 157 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.chips, card.ability.extra.mult, }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local all_light_suits = true
            for _, playing_card in ipairs(G.hand.cards) do
                if not playing_card:is_suit('Hearts', nil, true) and not playing_card:is_suit('Diamonds', nil, true) then
                    all_light_suits = false
                    break
                end
            end
            if all_light_suits then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end,
}
