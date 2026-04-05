SMODS.Blind {
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
    },
    boss = { min = 1, max = 10 },
    boss_colour = HEX('701814'),
    loc_vars = function(self)
        return { vars = { self.config.extra.xmult } }
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.post_trigger then
                return {
                    xmult = blind.effect.extra.xmult,
                    message = 'Decayed!',
                    card = context.blueprint_card or context.other_card or blind,
                }
            end
            if context.cardarea == G.play and context.main_scoring then
                return {
                    xmult = blind.effect.extra.xmult,
                    message = 'Decayed!',
                }
            end
        end
    end
}
