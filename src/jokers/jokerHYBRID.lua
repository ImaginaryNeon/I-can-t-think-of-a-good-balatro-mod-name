if Cryptid then
    SMODS.Joker {
        key = "hybrid",
        atlas = 'jonklers',
        rarity = 3,
        cost = 7,
        pos = { x = 5, y = 1 },
        config = {
            extra = {
                xmult_gain = 0.2,
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
else
    SMODS.Joker {
        key = "hybrid",
        atlas = 'jonklers',
        rarity = 3,
        cost = 7,
        pos = { x = 5, y = 1 },
        config = {
            extra = {
                xmult_gain = 0.2,
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
end
