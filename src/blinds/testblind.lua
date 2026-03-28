SMODS.Blind{
    key = 'fleshprison',
    atlas = 'bossbattle',
    pos = {
        x = 0,
        y = 0
    },
    config = {
 	extra = {
 		xmult = 0.9,
 	},
    boss = true,
    min = 3,
    boss_colour = HEX('f0fcfe'),
    loc_vars = function(self, info_queue, card)
        return{
            vars = {
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, blind, context)
    if context.cardarea == G.play and context.main_scoring then
    return{
                xmult = blind.ability.extra.xmult,
                message = 'Decayed!',
            }
    end
    if context.post_joker then
    return{
                xmult = blind.ability.extra.xmult,
                message = 'Decayed!',
            }
    end
end,
 }
}