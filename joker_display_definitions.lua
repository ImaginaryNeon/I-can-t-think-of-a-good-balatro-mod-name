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
            joker_card.ability.extra * JokerDisplay.calculate_joker_triggers(joker_card) or 0
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
        card.joker_display_values.dollars = math.floor(G.GAME.dollars / (2 * card.ability.extra.fee)) *
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
