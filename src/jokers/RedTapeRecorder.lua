SMODS.Joker {
    key = "redtape",
    atlas = 'jonklers',
    rarity = 2,
    cost = 6,
    pos = { x = 1, y = 3 },
    config = {
        extra = {
            chips = 0,
            mult = 0,
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.pre_discard and G.GAME.current_round.discards_used <= 0 and not context.hook then
            local text, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            if G.GAME.hands[text].level > 1 then
                card.ability.extra.chips = card.ability.extra.chips + G.GAME.hands[text].chips -- or l_chips,
                card.ability.extra.mult = card.ability.extra.mult + G.GAME.hands[text].mult    -- or l_mult,
                return {
                    level_up = -1,
                    level_up_hand = text
                }
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end
}
