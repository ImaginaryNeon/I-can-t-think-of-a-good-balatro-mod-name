SMODS.Blind {
    key = 'plague',
    atlas = 'mannpowerblind',
    pos = {
        y = 10
    },
    boss = { min = 1, max = 10 },
    boss_colour = HEX('ED712B'),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.cardarea == G.play and context.main_scoring then
                other_card.ability.perma_p_dollars = (other_card.ability.perma_p_dollars or 0) - 1
            end
        end
    end
}
