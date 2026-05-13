SMODS.Joker {
    key = "kingambit",
    rarity = 3,
    cost = 8,
    pos = { x = 3, y = 1 },
    config = { extra = { xmult_gain = 0.25, xmult = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            local fallen_cards = 0
            for _, removed_card in ipairs(context.removed) do
                fallen_cards = fallen_cards + 1
            end
            if fallen_cards > 0 then
                -- See note about SMODS Scaling Manipulation on the wiki
                card.ability.extra.xmult = card.ability.extra.xmult + fallen_cards * card.ability.extra.xmult_gain
                return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } } }
            end
        end
        if context.joker_type_destroyed and not context.blueprint then
            -- See note about SMODS Scaling Manipulation on the wiki
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
            return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } } }
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}

SMODS.Joker {
    key = "redbaron",
    rarity = 3,
    cost = 5,
    pos = { x = 3, y = 1 },
    display_size = { w = 71 * 1.2, h = 71 * 1.2 },
    config = { extra = { fee = 5, xmult_gain = 0.1, xmult = 1, } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.fee, card.ability.extra.xmult_gain, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.ante_change and context.ante_end then
            if G.GAME.dollars >= 2*card.ability.extra.fee then
                local numberofredbaronpizzastopurchase = math.floor(G.GAME.dollars / (2*card.ability.extra.fee))
                card.ability.extra.xmult = card.ability.extra.xmult + numberofredbaronpizzastopurchase * card.ability.extra.xmult_gain
                return {
                    money = -(numberofredbaronpizzastopurchase * card.ability.extra.fee)
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}
