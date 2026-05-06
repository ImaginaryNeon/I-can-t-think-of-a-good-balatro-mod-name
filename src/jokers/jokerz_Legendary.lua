SMODS.Joker {
    key = "legendary_mii",
    atlas = 'jonklers',
    rarity = 4,
    cost = 20,
    pos = { x = 3, y = 3 },
    soul_pos = { x = 4, y = 3 },
    config = {
        extra = {
            xmult_base = 1,
            xmult = 1,
            xmult_gain = 0.05,
            suit = "None",
            color = G.C.UI.TEXT_DARK
        },
    },
    loc_vars = function(self, info_queue, card)
        local heart_count = 0
        local diamond_count = 0
        local club_count = 0
        local spade_count = 0
        local other_count = 0
        local highest_count = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:is_suit("Hearts") then
                    heart_count = heart_count + 1
                end
                if playing_card:is_suit("Diamonds") then
                    diamond_count = diamond_count + 1
                end
                if playing_card:is_suit("Clubs") then
                    club_count = club_count + 1
                end
                if playing_card:is_suit("Spades") then
                    spade_count = spade_count + 1
                end
                if not playing_card:is_suit("Hearts") and not playing_card:is_suit("Diamonds") and not
                    playing_card:is_suit("Clubs") and not playing_card:is_suit("Spades") and not SMODS.has_no_suit(playing_card) then
                    other_count = other_count + 1
                end
            end
            if heart_count > diamond_count and heart_count > club_count and heart_count > spade_count and heart_count > other_count then
                card.ability.extra.suit = "Hearts"
                highest_count = heart_count
            elseif diamond_count > heart_count and heart_count > club_count and heart_count > spade_count and heart_count > other_count then
                card.ability.extra.suit = "Diamonds"
                highest_count = diamond_count
            elseif club_count > heart_count and club_count > diamond_count and club_count > spade_count and heart_count > other_count then
                card.ability.extra.suit = "Clubs"
                highest_count = club_count
            elseif spade_count > heart_count and spade_count > diamond_count and spade_count > club_count and heart_count > other_count then
                card.ability.extra.suit = "Spades"
                highest_count = spade_count
            elseif other_count > heart_count and other_count > diamond_count and other_count > club_count and other_count > spade_count then
                card.ability.extra.suit = "Other"
                highest_count = other_count
            else
                card.ability.extra.suit = "Spades"
                highest_count = spade_count
            end
        end
        if card.ability.extra.suit == "Hearts" then
            card.ability.extra.color = G.C.SUITS.Hearts
        elseif card.ability.extra.suit == "Diamonds" then
            card.ability.extra.color = G.C.SUITS.Diamonds
        elseif card.ability.extra.suit == "Clubs" then
            card.ability.extra.color = G.C.SUITS.Clubs
        elseif card.ability.extra.suit == "Spades" then
            card.ability.extra.color = G.C.SUITS.Spades
        elseif card.ability.extra.suit == "Other" then
            card.ability.extra.color = HEX('cc38f3')
        elseif card.ability.extra.suit == "None" then
            card.ability.extra.color = G.C.UI.TEXT_DARK
        end
        card.ability.extra.xmult = card.ability.extra.xmult_base + (card.ability.extra.xmult_gain * highest_count)
        return {
            vars = { card.ability.extra.xmult_base, card.ability.extra.xmult, card.ability.extra.xmult_gain, card.ability.extra.suit, colours = { card.ability.extra.color } }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                "1", "1", "0.05", "None", colours = { G.C.UI.TEXT_DARK }
            },
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local suits = {}
            for k, v in pairs(G.playing_cards) do
                for kk, vv in pairs(SMODS.Suits) do
                    if v:is_suit(vv.key) then
                        suits[vv.key] = (suits[vv.key] or 0) + 1
                    end
                end
            end
            local suit, count = 'Spades', 0
            for k, v in pairs(suits) do
                if v >= count then
                    suit, count = k, v
                end
            end
            if context.other_card:is_suit(suit) then
                return { xmult = card.ability.extra.xmult_base + (card.ability.extra.xmult_gain * count) }
            end
        end
    end
}
