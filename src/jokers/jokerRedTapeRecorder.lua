SMODS.Joker {
    key = "redtape",
    atlas = 'jonklers',
    rarity = 3,
    cost = 8,
    pos = { x = 1, y = 3 },
    blueprint_compat = true,
    perishable_compat = false,
    demicoloncompat = true,
    config = {
        extra = {
            chips = 0,
            mult = 0,
            unbound = "j_neonmod_redtapeunbound",
        }
    },
    attributes = { 'chips', 'mult', 'scaling', 'hand_level', 'discard', 'hand_type', 'overrule_compat', 'videogame' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.pre_discard and G.GAME.current_round.discards_used <= 0 and not context.hook and not context.blueprint then
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
        if context.forcetrigger then
            local text, _ = G.FUNCS.get_poker_hand_info(context.full_hand)
            if G.GAME.hands[text].level > 1 then
                card.ability.extra.chips = card.ability.extra.chips + G.GAME.hands[text].chips -- or l_chips,
                card.ability.extra.mult = card.ability.extra.mult + G.GAME.hands[text].mult    -- or l_mult,
                return {
                    level_up = -1,
                    level_up_hand = text,
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

SMODS.Rarity {
    key = "unbound",
    badge_colour = HEX('e03c9b'),
    default_weight = 0,
    pools = {
        ["Joker"] = true, --uses self.default_weight when polled
    },
    get_weight = function(self, weight, object_type)
        --print(G.GAME.selected_back.name)
        if G.GAME.selected_back.effect.center.key == "b_neonmod_hoopadeck" then
            return 999
        else
            return 0
        end
    end
}

SMODS.Joker {
    key = "redtapeunbound",
    atlas = 'jonklers2',
    no_collection = true,
    blueprint_compat = true,
    perishable_compat = false,
    demicoloncompat = true,
    rarity = "neonmod_unbound",
    cost = 6,
    pos = { x = 1, y = 3 },
    config = {
        extra = {
            chips = 0,
            mult = 0,
        }
    },
    attributes = { 'chips', 'mult', 'scaling', 'hand_level', 'discard', 'hand_type', 'unbound', 'videogame' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.pre_discard and not context.hook and not context.blueprint then
            local text, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            card.ability.extra.chips = card.ability.extra.chips + G.GAME.hands[text].chips -- or l_chips,
            card.ability.extra.mult = card.ability.extra.mult + G.GAME.hands[text].mult    -- or l_mult,
            return {
                level_up = -1,
                level_up_hand = text
            }
        end
        if context.forcetrigger then
            local text, _ = G.FUNCS.get_poker_hand_info(context.full_hand)
            card.ability.extra.chips = card.ability.extra.chips + G.GAME.hands[text].chips -- or l_chips,
            card.ability.extra.mult = card.ability.extra.mult + G.GAME.hands[text].mult    -- or l_mult,
            return {
                level_up = -1,
                level_up_hand = text,
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end,
    --in_pool = function(self, args) return false end
}
