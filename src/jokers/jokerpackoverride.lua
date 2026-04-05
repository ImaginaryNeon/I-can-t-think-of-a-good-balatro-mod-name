SMODS.Joker {
    key = 'IDFKMAN',
    atlas = 'jonklers',
    pos = {
        x = 3,
        y = 0
    },
    rarity = 2,
    cost = 8,
    calculate = function(self, card, context)
        if context.create_shop_booster then
            context.booster.config = { extra = 5, choose = 2 }
        end
    end
}
