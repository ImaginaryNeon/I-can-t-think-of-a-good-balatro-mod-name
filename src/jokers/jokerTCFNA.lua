SMODS.Joker {
    key = "tcfna",
    atlas = 'jonklers',
    rarity = 3,
    cost = 6,
    pos = { x = 0, y = 1 },
    config = {
        extra = {
            Emult = 1,
            Emult_mod = 0.002,
        },
    },
    loc_vars = function(self, info_queue, card)
        local min_count = 0
        local enhanced_count = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                do return { min_count == min_count + 0.5 } end
                if next(SMODS.get_enhancements(playing_card)) and playing_card:get_seal() and playing_card.edition then
                    enhanced_count = enhanced_count + 1
                end
                min_count = min_count + 0.5
            end
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local enhanced_count = 0
            local min_count = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if next(SMODS.get_enhancements(playing_card)) and playing_card:get_seal() and playing_card.edition then
                    enhanced_count = enhanced_count + 1
                end
                min_count = min_count + 0.5
                if enhanced_count >= min_count then
                    return {
                        Emult = 1 + card.ability.extra.Emult_mod * enhanced_count,
                    }
                else
                    return {
                        Emult = 1,
                    }
                end
            end
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if next(SMODS.get_enhancements(playing_card)) and playing_card:get_seal() and playing_card.edition then
                return true
            end
        end
        return false
    end
}
