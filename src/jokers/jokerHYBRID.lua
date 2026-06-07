local isCryptid = SMODS.find_mod("Cryptid")[1]
local isepic = isCryptid and "cry_epic" or 3
--local hybridpools = isCryptid and { ["Meme"] = true, } or {}
--if Cryptid then
SMODS.Joker {
    key = "hybrid",
    atlas = 'jonklers',
    rarity = 3,
    cost = 7,
    pos = { x = 5, y = 1 },
    config = {
        extra = {
            xmult_gain = 0.5,
            xmult = 1
        }
    },
    pools = { ["Meme"] = true, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult, '#' } }
    end,
    calculate = function(self, card, context)
        if context.post_trigger and context.other_card.ability and context.other_card.ability.set == "Joker" then
            -- add a triggered flag (unique to your mod)
            context.other_card.ability.neonmod_triggered = true
        end
        if context.ante_change and context.ante_end then
            -- remove triggered flags at end of ante
            -- code assumes all jokers are in G.jokers (optimal method to cover all possible joker cards omitted for brevity)
            for _, v in ipairs(G.jokers.cards) do
                if v.ability.neonmod_triggered == nil then -- filters for Jokers that have not triggered this ante
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                end
                v.ability.neonmod_triggered = nil
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}
--[[else
    SMODS.Joker {
        key = "hybrid",
        atlas = 'jonklers',
        rarity = 3,
        cost = 7,
        pos = { x = 5, y = 1 },
        config = {
            extra = {
                xmult_gain = 0.5,
                xmult = 1
            }
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult, '#' } }
        end,
        calculate = function(self, card, context)
            if context.post_trigger and context.other_card.ability and context.other_card.ability.set == "Joker" then
                -- add a triggered flag (unique to your mod)
                context.other_card.ability.neonmod_triggered = true
            end
            if context.ante_change and context.ante_end then
                -- remove triggered flags at end of ante
                -- code assumes all jokers are in G.jokers (optimal method to cover all possible joker cards omitted for brevity)
                for _, v in ipairs(G.jokers.cards) do
                    if v.ability.neonmod_triggered == nil then -- filters for Jokers that have not triggered this ante
                        card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                    end
                    v.ability.neonmod_triggered = nil
                end
            end
            if context.joker_main then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    }
end]]
SMODS.Joker {
    key = "tcfna",
    atlas = 'jonklers',
    rarity = isepic,
    cost = 9,
    pos = { x = 0, y = 1 },
    config = {
        extra = {
            emult = 1,
            emult_mod = 0.01,
        },
    },
    pools = { ["Meme"] = true, },
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
        if enhanced_count >= min_count then
            card.ability.extra.emult = 1 + (enhanced_count * card.ability.extra.emult_mod)
        else
            card.ability.extra.emult = 1
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
                if enhanced_count >= min_count then
                    card.ability.extra.emult = 1 + (enhanced_count * card.ability.extra.emult_mod)
                else
                    card.ability.extra.emult = 1
                end
            end
            if enhanced_count >= min_count then
                return {
                    emult = card.ability.extra.emult
                }
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
