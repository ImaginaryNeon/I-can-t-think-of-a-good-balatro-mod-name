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

SMODS.Joker {
    key = "redtapeunbound",
    atlas = 'jonklers',
    no_collection = true,
    rarity = 2,
    cost = 6,
    weight = 0,
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
        if context.pre_discard and not context.hook then
            local text, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            card.ability.extra.chips = card.ability.extra.chips + G.GAME.hands[text].chips -- or l_chips,
            card.ability.extra.mult = card.ability.extra.mult + G.GAME.hands[text].mult    -- or l_mult,
            return {
                level_up = -1,
                level_up_hand = text
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end,
    in_pool = function(self, args) return false end
}
SMODS.Challenge {
    key = "rewound",
    restrictions = {
        banned_cards = {

        },
        banned_other = {},
    },
    jokers = {
        { id = 'j_neonmod_redtapeunbound', eternal = true }
    },
    deck = {
        type = "Challenge Deck",
        -- seal = 'Blue',
        cards = {
            { s = 'C', r = 'A', g = 'Blue' },
            { s = 'D', r = 'A', g = 'Blue' },
            { s = 'H', r = 'A', g = 'Blue' },
            { s = 'S', r = 'A', g = 'Blue' },
            { s = 'C', r = 'K', g = 'Blue' },
            { s = 'D', r = 'K', g = 'Blue' },
            { s = 'H', r = 'K', g = 'Blue' },
            { s = 'S', r = 'K', g = 'Blue' },
            { s = 'C', r = 'Q', g = 'Blue' },
            { s = 'D', r = 'Q', g = 'Blue' },
            { s = 'H', r = 'Q', g = 'Blue' },
            { s = 'S', r = 'Q', g = 'Blue' },
            { s = 'C', r = 'J', g = 'Blue' },
            { s = 'D', r = 'J', g = 'Blue' },
            { s = 'H', r = 'J', g = 'Blue' },
            { s = 'S', r = 'J', g = 'Blue' },
            { s = 'C', r = 'T' },
            { s = 'D', r = 'T' },
            { s = 'H', r = 'T' },
            { s = 'S', r = 'T' },
            { s = 'C', r = '9' },
            { s = 'D', r = '9' },
            { s = 'H', r = '9' },
            { s = 'S', r = '9' },
            { s = 'C', r = '8' },
            { s = 'D', r = '8' },
            { s = 'H', r = '8' },
            { s = 'S', r = '8' },
            { s = 'C', r = '7' },
            { s = 'D', r = '7' },
            { s = 'H', r = '7' },
            { s = 'S', r = '7' },
            { s = 'C', r = '6' },
            { s = 'D', r = '6' },
            { s = 'H', r = '6' },
            { s = 'S', r = '6' },
            { s = 'C', r = '5' },
            { s = 'D', r = '5' },
            { s = 'H', r = '5' },
            { s = 'S', r = '5' },
            { s = 'C', r = '4' },
            { s = 'D', r = '4' },
            { s = 'H', r = '4' },
            { s = 'S', r = '4' },
            { s = 'C', r = '3' },
            { s = 'D', r = '3' },
            { s = 'H', r = '3' },
            { s = 'S', r = '3' },
            { s = 'C', r = '2' },
            { s = 'D', r = '2' },
            { s = 'H', r = '2' },
            { s = 'S', r = '2' },
        }
    },
}
