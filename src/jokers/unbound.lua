SMODS.Joker:take_ownership('joker', -- object key (class prefix not required)
    {                               -- table of properties to change from the existing object
        config = { mult = 4, extra = { unbound = "j_neonmod_jokerunbound", }, },
    },
    true -- silent | suppresses mod badge
)
SMODS.Joker {
    key = 'jokerunbound',
    atlas = 'jonklers2',
    pos = { x = 0, y = 1 },
    soul_pos = { x = 3, y = 1 },
    config = {
        extra = {
            xmult = 4,
        }
    },
    blueprint_compat = true,
    demicoloncompat = false,
    no_collection = true,
    attributes = { 'xmult', 'unbound' },
    rarity = "neonmod_unbound",
    cost = 10,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Joker {
    key = 'unboundradio',
    atlas = 'jonklers2',
    pos = { x = 0, y = 1 },
    soul_pos = { x = 1, y = 1 },
    config = {
        extra = {
            repetitions = 2,
        }
    },
    blueprint_compat = true,
    demicoloncompat = false,
    no_collection = true,
    attributes = { 'retrigger', 'rank', 'two', 'five', 'eight', 'unbound', 'videogame' },
    rarity = "neonmod_unbound",
    cost = 10,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.repetitions
            }
        }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card:get_id() == 8 or
                context.other_card:get_id() == 5 or
                context.other_card:get_id() == 2 then
                print(G.GAME.selected_back.name)
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end
} --]]

SMODS.Joker {
    key = "redtapeunbound",
    atlas = 'jonklers2',
    no_collection = true,
    blueprint_compat = true,
    perishable_compat = false,
    demicoloncompat = true,
    rarity = "neonmod_unbound",
    cost = 10,
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
SMODS.Joker {
    key = "marksmanunbound",
    atlas = 'jonklers2',
    no_collection = true,
    blueprint_compat = true,
    demicoloncompat = false,
    rarity = "neonmod_unbound",
    cost = 10,
    attributes = { 'retrigger', 'videogame' },
    pos = { x = 4, y = 1 },
    pixel_size = { w = 52, h = 95 },
    to_number = to_number or function(x) return x end,
    config = { extra = { repetitions = 1, dollars = 15 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.repetitions,
                card.ability.extra.dollars,
                card.ability.extra.repetitions *
                math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars)
            }
        }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and (to_number(card.ability.extra.repetitions *
                math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars))) > 0 then
            return {
                repetitions = to_number(card.ability.extra.repetitions *
                    math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars))
            }
        end
    end,
}
