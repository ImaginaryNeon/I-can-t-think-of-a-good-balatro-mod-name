SMODS.Joker {
    key = 'dangeresque',
    atlas = 'jonklers',
    pos = { x = 2, y = 1 },
    config = { extra = { odds = 4, dollars = 100 } },
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
