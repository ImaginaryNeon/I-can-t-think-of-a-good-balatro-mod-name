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
        local highest_count = 0
        if G.playing_cards then
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
            card.ability.extra.suit = suit
            highest_count = count
        end
        --[[if card.ability.extra.suit == "Hearts" then
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
        end]]
        if not (card.ability.extra.suit == "None") then
            if G.C.SUITS[card.ability.extra.suit] then
                card.ability.extra.color = G.C.SUITS[card.ability.extra.suit]
            else
                card.ability.extra.color = HEX('1b2e53')
            end
        else
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

SMODS.ObjectType({
    key = "neonmod_Passive_Utility", -- The prefix is not added automatically so it's recommended to add it yourself
    default = "j_smeared",
    cards = {
        j_four_fingers = true,
        j_credit_card = true,
        j_chaos = true,
        j_pareidolia = true,
        j_splash = true,
        j_shortcut = true,
        j_burglar = true,
        -- j_diet_cola = true, -- unsure if this one should count
        -- j_midas_mask = true,
        j_to_the_moon = true,
        j_juggler = true,
        j_drunkard = true,
        -- j_ticket = true,
        -- j_certificate = true,
        j_smeared = true,
        j_ring_master = true,
        j_merry_andy = true,
        j_oops = true,
        -- j_invisible = true,
        j_astronomer = true,
        j_chicot = true,
        -- j_joker = true,
        --- Cryptid shit
        -- j_cry_astral_bottle = true,
        j_cry_rotten_egg = true,
        j_cry_blurred = true,
        j_cry_booster = true,
        -- j_cry_broken_sync_catalyst = true,
        j_cry_buttercup = true,
        j_cry_caeruleum = true,
        j_cry_candy_buttons = true,
        j_cry_candy_sticks = true,
        j_cry_cat_owl = true,
        -- j_cry_copypaste = true,
        j_cry_crustulum = true,        -- very edge of counting, but does just have the free reroll passive, so fine
        j_cry_curse_sob = true,
        ["j_cry_Double Scale"] = true, -- idk man that's how it is in the localization
        j_cry_effarcire = true,
        -- j_cry_equilib = true,
        j_cry_error = true,
        j_cry_fractal = true,
        -- j_cry_eyeofhagane = true, -- the fuck is this???
        -- j_cry_flip_side = true,
        -- j_cry_huntingseason = true,
        -- j_cry_kittyprinter = true,
        -- j_cry_macabre = true,
        j_cry_maximized = true,
        j_cry_maze = true,
        -- j_cry_mellowcreme = true,
        -- j_cry_monopoly_money = true,
        -- j_cry_necromancer = true,
        j_cry_negative = true,
        -- j_cry_oldcandy = true,
        j_cry_panopticon = true,
        -- j_cry_pot_of_jokes = true,
        -- j_cry_carved_pumpkin = true,
        j_cry_redeo = true,
        j_cry_Scalae = true,
        -- j_cry_seal_the_deal = true,
        j_cry_soccer = true,
        j_cry_yarnball = true,
        j_cry_paved_joker = true,
        -- j_cry_sync_catalyst = true,
        j_cry_tenebris = true,
        j_cry_universum = true, -- why are half of cryptid's passive jokers just the fucking exotics man
        -- j_cry_huntingseason = true,
    },
})
SMODS.Joker {
    key = "jester_mii",
    atlas = 'jonklers',
    rarity = 4,
    cost = 20,
    attributes = { 'joker' },
    pos = { x = 3, y = 5 },
    soul_pos = { x = 4, y = 5 },
    config = {
        extra = {
            odds = 4
        },
    },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'neonmod_jester_mii')
        --info_queue[#info_queue + 1] = { key = 'c_lovers', set = 'Tarot', config = { max_highlighted = 1, mod_conv = 'm_wild' } }
        info_queue[#info_queue + 1] = G.P_CENTERS.c_lovers
        if not self.edition or (self.edition and not self.edition.negative) then
            info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        end
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            for _, lovers in ipairs(SMODS.find_card("c_lovers")) do
                if SMODS.pseudorandom_probability(card, 'neonmod_jester_mii', 1, card.ability.extra.odds) then
                    SMODS.add_card {
                        set = 'Joker',
                        edition = 'e_negative',
                        key_append = 'neonmod_jester_mii' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                    }
                end
            end
        end
    end
}

SMODS.Joker { -- Hands start with 999 Chips and 99 Mult, unless current Chips/Mult is greater
    key = "flowery",
    atlas = 'jonklers',
    rarity = 4,
    cost = 20,
    blueprint_compat = false,
    attributes = { 'joker' },
    pos = { x = 3, y = 7 },
    soul_pos = { x = 4, y = 7 },
    config = {
        extra = {
            chips = 999,
            mult = 99,
            unbound = "j_neonmod_omegaflowery",
        },
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.modify_hand and not context.blueprint then
            mult = mod_mult(math.max(mult, card.ability.extra.mult))
            hand_chips = mod_chips(math.max(hand_chips, card.ability.extra.chips))
            update_hand_text({ sound = 'chips2', modded = true }, { chips = hand_chips, mult = mult })
        end
        if context.joker_main then
            local list = { "Sorry to keep you waiting!", "Leaf it to me!", "All according to plant!",
                "Sorry to keep a lady in waiting.", "All according to plant!", "Jarona!", "Mysterious wind...", "Glue!",
                "I'm sorry once again I kept a lady in waiting!", "I'm only trying to help you!",
                "Hey guys, I think I found a glue!", "Here I come, San Frandisco!", "Heh, it's my Jarona!",
                "Grown like a turnip!", "Give to you!", "Flowers blooms in your heart.", "All according to plant!",
                "Sustingus!", "They're eating my flesh!", "Blingo Blizzard!" }
            local random_element = pseudorandom_element(list, "neonmod_jarona" .. G.GAME.round_resets.ante)
            return { message = random_element, colour = G.C.GOLD, }
        end
    end
}

SMODS.Joker { -- All hands below level 99 are considered level 99, all hands are considered to contain all hands.
    key = "omegaflowery",
    atlas = 'jonklers',
    rarity = "neonmod_unbound",
    cost = 20,
    blueprint_compat = false,
    attributes = { 'joker' },
    pos = { x = 5, y = 7 },
    soul_atlas = 'omega',
    soul_pos = { y = 0 },
    config = {
        extra = {
            level = 99,
        },
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { math.floor(card.ability.extra.level) } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if G.GAME.hands[context.scoring_name].level < math.floor(card.ability.extra.level) then
                local list = { "LEND ME YOUR POWER!", "WITH YOUR POWERS COMBINED!", "TAKE THAT!", "OMEGA FLOWERY!" }
                local random_element = pseudorandom_element(list, "neonmod_omegajarona" .. G.GAME.round_resets.ante)
                return {
                    level_up = to_number(math.max(
                        (math.floor(card.ability.extra.level) - G.GAME.hands[context.scoring_name].level), 0)),
                    message = random_element,
                    colour = G.C.GOLD,
                }
            end
        end
        if context.evaluate_poker_hand and not context.blueprint then
            for key, hands in pairs(context.poker_hands) do
                if not next(hands) then
                    hands[1] = SMODS.shallow_copy(context.full_hand)
                end
            end
        end
    end
}
