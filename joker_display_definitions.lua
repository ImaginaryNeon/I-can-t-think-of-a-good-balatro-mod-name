local jd_def = JokerDisplay.Definitions -- You can assign it to a variable to use as shorthand

jd_def["j_neonmod_testobjectpleaseignore"] = {
    text = {
        { text = "+",                       colour = G.C.CHIPS },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult", colour = G.C.CHIPS, },
    },
    reminder_text = {
        { text = "" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult", colour = G.C.MULT, scale = 0.4 }
    },
}
jd_def["j_neonmod_portalradio"] = {
    reminder_text = {
        { text = "(8,5,2)" },
    },
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        return JokerDisplay.in_scoring(playing_card, scoring_hand) and
            (playing_card:get_id() == 8 or playing_card:get_id() == 5 or
                playing_card:get_id() == 2) and
            joker_card.ability.extra.repetitions * JokerDisplay.calculate_joker_triggers(joker_card) or 0 -- this line?
    end
}
jd_def["j_neonmod_loremipsum"] = { -- Lorem Ipsum
    text = {
        { text = "+",                       colour = G.C.CHIPS },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult", colour = G.C.CHIPS },
    },
    reminder_text = {
        { text = "+",                       colour = G.C.MULT },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult", colour = G.C.MULT },
    },
}
jd_def["j_neonmod_stupendium"] = { -- Stupendi-Joker
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
}

jd_def["j_neonmod_kingambit"] = { -- Leader's Crest
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" }
            }
        }
    }
}

jd_def["j_neonmod_redbaron"] = { -- Red Baron Pizza
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" }
            }
        }
    },
    reminder_text = {
        { text = "-$",                             colour = G.C.GOLD },
        { ref_table = "card.joker_display_values", ref_value = "dollars", colour = G.C.GOLD },
        { text = " (Ante)", },
    },
    calc_function = function(card)
        card.joker_display_values.dollars = math.floor(math.min(G.GAME.dollars / (2 * card.ability.extra.fee), 50)) *
            card.ability.extra.fee
        card.joker_display_values.localized_text = "(" .. localize("k_round") .. ")"
    end
}

jd_def["j_neonmod_dark_fountain"] = { -- Dark Fountain
    text = {
        { ref_table = "card.ability.extra", ref_value = "total_mods", retrigger_type = "mult", colour = G.C.FILTER, scale = 0.4 },
        { text = "Jokers",                  scale = 0.4 },
    },
    extra = {
        {
            { text = "X",                       scale = 0.35,       colour = G.C.RED },
            { ref_table = "card.ability.extra", ref_value = "test", retrigger_type = "exp", colour = G.C.RED, scale = 0.35 },
            { text = " Boss Blind size",        scale = 0.35 },
        },
    },
}

jd_def["j_neonmod_hybrid"] = { -- H Y B R I D
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" }
            }
        }
    }
}

jd_def["j_neonmod_tcfna"] = { -- The Campaign for North Africa: The Desert War, 1940-43
    text = {
        {
            border_nodes = {
                { text = "^" },
                { ref_table = "card.ability.extra", ref_value = "emult", retrigger_type = "exp" }
            }
        }
    },
    reminder_text = {
        { text = "(",                              colour = G.C.UI.TEXT_INACTIVE },
        { ref_table = "card.joker_display_values", ref_value = "enhanced_count" },
        { text = "/", },
        { ref_table = "card.joker_display_values", ref_value = "min_count" },
        { text = ")",                              colour = G.C.UI.TEXT_INACTIVE },
    },
    calc_function = function(card)
        card.joker_display_values.enhanced_count = 0
        card.joker_display_values.min_count = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if next(SMODS.get_enhancements(playing_card)) and playing_card:get_seal() and playing_card.edition then
                    card.joker_display_values.enhanced_count = card.joker_display_values.enhanced_count + 1
                end
                card.joker_display_values.min_count = card.joker_display_values.min_count + 0.5
            end
        end
        card.joker_display_values.active = card.joker_display_values.enhanced_count and
            card.joker_display_values.enhanced_count >= card.joker_display_values.min_count
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children then
            local colour = card.joker_display_values.active and G.C.GREEN or G.C.UI.TEXT_INACTIVE
            if reminder_text.children[2] then
                reminder_text.children[2].config.colour = colour
            end
            if reminder_text.children[3] then
                reminder_text.children[3].config.colour = colour
            end
            if reminder_text.children[4] then
                reminder_text.children[4].config.colour = colour
            end
        end
    end
}

jd_def["j_neonmod_joyconl"] = { -- JoyCon (L)
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
}

jd_def["j_neonmod_joyconr"] = { -- JoyCon (R)
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local numerator, denominator = (G.GAME.probabilities.normal or 1), card.ability.extra.odds
        if SMODS then numerator, denominator = SMODS.get_probability_vars(card, 1, denominator, 'neonmod_joyconr') end
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end
}

local to_number = to_number or function(x) return x end

jd_def["j_neonmod_marksmancoin"] = { -- Marksman Coin
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        local first_card = scoring_hand and JokerDisplay.calculate_leftmost_card(scoring_hand)
        return first_card and playing_card == first_card and
            ((joker_card.ability.extra.repetitions *
                    math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / joker_card.ability.extra.dollars)) *
                JokerDisplay.calculate_joker_triggers(joker_card)) or 0
    end,
    text = {
        { ref_table = "card.joker_display_values", ref_value = "retriggercount", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.FILTER },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    reminder_text = {
        { text = "(First card)", },
    },
    calc_function = function(card)
        local numerator, denominator = (G.GAME.probabilities.normal or 1), card.ability.extra.odds
        if SMODS then numerator, denominator = SMODS.get_probability_vars(card, 1, denominator, 'neonmod_marksmancoin') end
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
        card.joker_display_values.retriggercount = to_number(card.ability.extra.repetitions *
            math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars))
    end
}

jd_def["j_neonmod_marksman"] = { -- Marksman Gun
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        if Cryptid then
            local final_card = scoring_hand and JokerDisplay.calculate_rightmost_card(scoring_hand)
            return final_card and playing_card == final_card and
                ((joker_card.ability.extra.repetitions *
                        math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / joker_card.ability.extra.dollars)) *
                    JokerDisplay.calculate_joker_triggers(joker_card)) or 0
        else
            local first_card = scoring_hand and JokerDisplay.calculate_leftmost_card(scoring_hand)
            return first_card and playing_card == first_card and
                ((joker_card.ability.extra.repetitions *
                        math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / joker_card.ability.extra.dollars)) *
                    JokerDisplay.calculate_joker_triggers(joker_card)) or 0
        end
    end,
    text = {
        { ref_table = "card.joker_display_values", ref_value = "retriggercount", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.FILTER },
    reminder_text = {
        { text = "-$",                             colour = G.C.GOLD },
        { ref_table = "card.joker_display_values", ref_value = "cost", colour = G.C.GOLD, retrigger_type = "mult" },
    },
    calc_function = function(card)
        card.joker_display_values.retriggercount = to_number(card.ability.extra.repetitions *
            math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars))
        card.joker_display_values.cost = to_number(card.ability.extra.fee * (card.ability.extra.repetitions *
            math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars)))
    end
}

jd_def["j_neonmod_cheatcode"] = { -- Cheat Code
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "suits", scale = 0.25, colour = G.C.WHITE }
    },
    calc_function = function(card)
        card.joker_display_values.suits = G.GAME.current_round.neonmod_cheatcode_cards and
            table.concat(G.GAME.current_round.neonmod_cheatcode_cards, ', ', 1, 4) or
            "Lamp, Oil, Rope, Bombs"
    end
}

jd_def["j_neonmod_passport"] = { -- Passport
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
}

jd_def["j_neonmod_Wiimote"] = { -- Wiimote
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
    calc_function = function(card)
        card.joker_display_values.chips = card.ability.extra.mult * card.ability.extra.max_speed
        if not (card.joker_display_values.chips > 0) then
            card.joker_display_values.chips = 0
        end
    end
}

jd_def["j_neonmod_licensetomaim"] = { -- License to Maim
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN },
    calc_function = function(card)
        local numerator, denominator = (G.GAME.probabilities.normal or 1), card.ability.extra.odds
        if SMODS then numerator, denominator = SMODS.get_probability_vars(card, 1, denominator, 'neonmod_licensetomaim') end
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end
}

jd_def["j_neonmod_mike"] = { -- why
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
    calc_function = function(card)
        card.joker_display_values.mult = card.ability.extra.mult * (G.GAME.neonmod_devicecount or 0)
    end
}

jd_def["j_neonmod_dangeresque"] = { -- Dangeresque, Too?
    text = {
        { text = "$" },
        { ref_table = "card.ability.extra", ref_value = "dollars", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MONEY },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN },
    calc_function = function(card)
        local numerator, denominator = (G.GAME.probabilities.normal or 1), card.ability.extra.odds
        if SMODS then numerator, denominator = SMODS.get_probability_vars(card, 1, denominator, 'neonmod_dangeresque') end
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end
}

jd_def["j_neonmod_ironcurtain"] = { -- Iron Curtain
    text = {
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
        { text = "x",                              scale = 0.35 },
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "xmult" }
            }
        }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE },
        { text = ")" },
    },
    extra = {
        {
            { text = "(Ammo: " },
            { ref_table = "card.ability.extra", ref_value = "ammo", colour = G.C.FILTER },
            { text = ")" },
        }
    },
    calc_function = function(card)
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        local count = 0
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:is_face() then
                    count = count +
                        JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.count = math.min(card.ability.extra.ammo, count)
        card.joker_display_values.localized_text = localize("k_face_cards")
    end
}

jd_def["j_neonmod_timepiece"] = { -- Enthusiast's Timepiece
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" }
            }
        }
    }
}

jd_def["j_neonmod_redtape"] = { -- Red-Tape
    text = {
        { text = "+",                       colour = G.C.CHIPS },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult", colour = G.C.CHIPS, },
    },
    reminder_text = {
        { text = "+",                       colour = G.C.MULT },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult", colour = G.C.MULT, scale = 0.4 }
    },
}

jd_def["j_neonmod_redtapeunbound"] = { -- Red-Tape (Unbound)
    text = {
        { text = "+",                       colour = G.C.CHIPS },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult", colour = G.C.CHIPS, },
    },
    reminder_text = {
        { text = "+",                       colour = G.C.MULT },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult", colour = G.C.MULT, scale = 0.4 }
    },
}

jd_def["j_neonmod_fraudsecond"] = { -- Through the Mirror
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active_text" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.is_active = G.GAME.current_round.hands_played == 0
        card.joker_display_values.active_text = localize("jdis_" ..
            (card.joker_display_values.is_active and "active" or "inactive"))
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children and reminder_text.children[2] then
            reminder_text.children[2].config.colour = card.joker_display_values.is_active and G.C.GREEN or
                G.C.UI.TEXT_INACTIVE
        end
    end
}

jd_def["j_neonmod_fraudthird"] = { -- Disintegration Loop
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.SECONDARY_SET.Planet },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:get_id() and (scoring_card:get_id() == 8 or scoring_card:get_id() == 3) then
                    count = count +
                        JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.count = count
        local numerator, denominator = (G.GAME.probabilities.normal or 1), card.ability.extra.odds
        if SMODS then numerator, denominator = SMODS.get_probability_vars(card, 1, denominator, 'fraudthird') end
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end
}

jd_def["j_neonmod_fraudclimax"] = { -- Final Flight
    text = {
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
        { text = "x",                              scale = 0.35 },
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "xmult" }
            }
        }
    },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text" },
    },
    calc_function = function(card)
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        local count = 0
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:get_id() and scoring_card:get_id() == 8 or scoring_card:get_id() == 4 then
                    count = count +
                        JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.count = count
        card.joker_display_values.localized_text = "(8,4)"
    end
}
jd_def["j_neonmod_fraudclimax_alt"] = { -- Final Flight
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "xmult" }
            }
        }
    },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text" },
    },
    calc_function = function(card)
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        local count = 0
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:get_id() and scoring_card:get_id() == 8 or scoring_card:get_id() == 4 then
                    count = count +
                        JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.count = count
        card.joker_display_values.xmult = card.ability.extra.xmult + (count * card.ability.extra.xmult_mod)
        card.joker_display_values.localized_text = "(8,4)"
    end
}

jd_def["j_neonmod_violencesecret"] = { -- Hell Bath No Fury
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.SECONDARY_SET.Spectral },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text" },
    },
    calc_function = function(card)
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:get_id() and (scoring_card:get_id() == 7) and next(SMODS.get_enhancements(scoring_card)) then
                    count = count + 1
                end
            end
        end
        card.joker_display_values.count = count
        card.joker_display_values.localized_text = "(Enhanced 7s)"
    end
}

jd_def["j_neonmod_legendary_mii"] = { -- Aw man
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "suit", colour = G.C.FILTER },
        { text = ")" },
    },
    calc_function = function(card)
        local countreal = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        local suit, count = (card.ability.extra.suit or 'Spades'), 0
        if text ~= 'Unknown' then
            local suits = {}
            for k, v in pairs(G.playing_cards) do
                for kk, vv in pairs(SMODS.Suits) do
                    if v:is_suit(vv.key) then
                        suits[vv.key] = (suits[vv.key] or 0) + 1
                    end
                end
            end
            for k, v in pairs(suits) do
                if v >= count and not (v == 0) then
                    suit, count = k, v
                end
            end
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:is_suit(suit) then
                    countreal = countreal +
                        JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.x_mult = card.ability.extra.xmult ^ countreal
        card.joker_display_values.suit = suit
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[2] then
            reminder_text.children[2].config.colour = lighten(
                (G.C.SUITS[card.joker_display_values.suit] or card.ability.extra.color), 0.35)
        end
    end
}

jd_def["j_neonmod_jester_mii"] = { -- Hugh Morris
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.FILTER },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local count = 0
        for _, lovers in ipairs(SMODS.find_card("c_lovers")) do
            count = count + 1
        end
        card.joker_display_values.count = count
        local numerator, denominator = (G.GAME.probabilities.normal or 1), card.ability.extra.odds
        if SMODS then numerator, denominator = SMODS.get_probability_vars(card, 1, denominator, 'neonmod_jester_mii') end
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end
}

jd_def["j_neonmod_secret"] = { -- We Are Number One!
    text = {
        {
            border_nodes = {
                { text = "^" },
                { ref_table = "card.ability.extra", ref_value = "emult", retrigger_type = "exp" }
            }
        },
        border_colour = G.C.DARK_EDITION
    }
}

jd_def["j_neonmod_scope"] = { -- Scope Lens
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "xmult" }
            }
        }
    },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local numerator, denominator = (G.GAME.probabilities.normal or 1), math.max(G.GAME.current_round.hands_left, 1)
        if SMODS then numerator, denominator = SMODS.get_probability_vars(card, 1, denominator, 'neonmod_scopelens') end
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end
}

jd_def["j_neonmod_still_alive"] = { -- Still Alive
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" }
            }
        }
    }
}
