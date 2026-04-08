SMODS.Joker {
    key = "tcfna",
    atlas = 'jonklers',
    rarity = "cry_epic",
    cost = 9,
    pos = { x = 0, y = 1 },
    config = {
        extra = {
            emult = 1,
            emult_mod = 0.01,
        },
    },
    loc_vars = function(self, info_queue, card)
        local enhanced_count = 0
        local min_count = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if next(SMODS.get_enhancements(playing_card)) and playing_card:get_seal() and playing_card.edition then
                    enhanced_count = enhanced_count + 1
                end
                min_count = min_count + 0.5
            end
        end
        return { vars = { card.ability.extra.emult, card.ability.extra.emult_mod, enhanced_count, min_count } }
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
                SMODS.scale_card(
                    {
                        ref_table = card.ability.extra,
                        ref_value = "emult",
                        scalar_value = "emult_mod",
                        operation = function(ref_table, ref_value, initial, scalar_value)
                            ref_table[ref_value] = initial + (scalar_value * enhanced_count)
                        end
                    }
                )
                if enhanced_count >= min_count then
                    return {
                        emult = card.ability.extra.emult
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
