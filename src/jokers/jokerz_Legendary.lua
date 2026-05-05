SMODS.Joker {
    key = "legendary_mii",
    atlas = 'jonklers',
    rarity = 4,
    cost = 20,
    pos = { x = 3, y = 3 },
    soul_pos = { x = 4, y = 3 },
    config = {
        extra = {
            xmult = 1.5,
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
                card.ability.extra.suit = "None"
            end
        end
        if card.ability.extra.suit = "Hearts" then
            card.ability.extra.color = G.C.SUITS.Hearts
        elseif card.ability.extra.suit = "Diamonds" then
            card.ability.extra.color = G.C.SUITS.Diamonds
        elseif card.ability.extra.suit = "Clubs" then
            card.ability.extra.color = G.C.SUITS.Clubs
        elseif card.ability.extra.suit = "Spades" then
            card.ability.extra.color = G.C.SUITS.Spades
        elseif card.ability.extra.suit = "Other" then
            card.ability.extra.color = HEX('cc38f3')
        elseif card.ability.extra.suit = "None" then
            card.ability.extra.color = G.C.UI.TEXT_DARK
        end
        return {
            vars = { card.ability.extra.xmult, card.ability.extra.suit },
            colours = { card.ability.extra.color }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
                --{
            local heart_count = 0
            local diamond_count = 0
            local club_count = 0
            local spade_count = 0
            local other_count = 0
            local highest_count = 0
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
                card.ability.extra.suit = "None"
            end
            --}
            if card.ability.extra.suit = "Other" then
                if not context.other_card:is_suit("Hearts") and not context.other_card:is_suit("Diamonds") and not 
                    context.other_card:is_suit("Clubs") and not context.other_card:is_suit("Spades") and not SMODS.has_no_suit(context.other_card) then
                return {
                    xmult = card.ability.extra.xmult
                }
                end
            end
            if not card.ability.extra.suit = "None" then
                if context.other_card:is_suit(card.ability.extra.suit) then
                    return {
                        xmult = card.ability.extra.xmult
                    }
                end
            end
        end
    end
}
