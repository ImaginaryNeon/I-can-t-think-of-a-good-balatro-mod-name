local isSynth = SMODS.find_mod("synthb")[1]
Neonmod = Neonmod or {}
Neonmod.mod = SMODS.current_mod
if isSynth then
    SMODS.Attribute { key = "Portal" }
    SMODS.Attribute { key = "Ellen McClain" }
    SMODS.Attribute { key = "Jonathan Coulton" }
    SMODS.Attribute { key = "GLaDOS" }
    SMODS.Joker {
        key = "still_alive",
        blueprint_compat = false,
        rarity = 3,
        cost = 7,
        atlas = "jonklers",
        pos = { x = 0, y = 6 },
        synthb_credits = {
            Artist = "ImaginaryNeon"
        },
        attributes = { "mult", "scaling", "reset", "Portal", "song", "Jonathan Coulton", "Ellen McClain", "GLaDOS" },
        config = {
            extra = {
                xmult = 1,
                xmult_gain = 0.5,
            }
        },
        loc_vars = function(self, info_queue, card)
            SynthB.song_info(info_queue, "still_alive")
            return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult } }
        end,
        calculate = function(self, card, context)
            if context.remove_playing_cards and not context.blueprint and not context.retrigger_joker then
                local fallen_cards = 0
                for _, removed_card in ipairs(context.removed) do
                    fallen_cards = fallen_cards + 1
                end
                if fallen_cards > 0 then
                    for _ = 1, fallen_cards do
                        SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = 'xmult',
                            scalar_value = 'xmult_gain',
                            no_message = true
                        })
                    end
                    return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } } }
                end
            end
            if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
                if context.beat_boss and card.ability.extra.xmult > 1 then
                    card.ability.extra.xmult = 1
                    return {
                        message = localize('k_reset'),
                        colour = G.C.RED
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
    SynthB.inject_song_data {
        key = "still_alive", -- related card's key without "j_modprefix_"
        prefix = "j_neonmod_",
        link = "https://www.youtube.com/watch?v=-JZLqTnZZlY",
        atlas = "neonmod_stillalive",
        pos = { x = 0, y = 0 } -- position on the atlas
    }

    SMODS.Joker {
        key = "want_you_gone",
        blueprint_compat = false,
        rarity = 3,
        cost = 8,
        atlas = "jonklers",
        pos = { x = 1, y = 6 },
        synthb_credits = {
            Artist = "ImaginaryNeon"
        },
        attributes = { "xmult", "scaling", "rank", "face", "destroy_card", "enhancements", "Portal", "song", "Jonathan Coulton", "Ellen McClain", "GLaDOS" },
        config = {
            extra = {
                xmult = 1,
                xmult_gain = 0.15,
            }
        },
        loc_vars = function(self, info_queue, card)
            SynthB.song_info(info_queue, "want_you_gone")
            return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult } }
        end,
        calculate = function(self, card, context)
            if context.destroy_card and not context.blueprint then
                if next(SMODS.get_enhancements(context.destroy_card)) and context.cardarea == G.play and not (context.destroy_card:is_face()) then
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = 'xmult',
                        scalar_value = 'xmult_gain',
                        no_message = true
                    })
                    return {
                        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                        colour = G.C.MULT,
                        remove = true
                    }
                end
                if context.joker_main then
                    return {
                        xmult = card.ability.extra.xmult
                    }
                end
            end
        end
    }
    SynthB.inject_song_data {
        key = "want_you_gone", -- related card's key without "j_modprefix_"
        prefix = "j_neonmod_",
        link = "https://youtu.be/fEnpB9fPUbg",
        atlas = "neonmod_stillalive",
        pos = { x = 0, y = 0 } -- position on the atlas
    }
    SMODS.Joker {
        key = "you_wouldnt_know",
        blueprint_compat = false,
        rarity = 2,
        cost = 6,
        atlas = "jonklers",
        pos = { x = 2, y = 6 },
        pixel_size = { w = 70, h = 94 },
        synthb_credits = {
            Artist = "ImaginaryNeon"
        },
        attributes = { "economy", "boss_blind", "Portal", "song", "Jonathan Coulton", "Ellen McClain", "GLaDOS" },
        config = {
            extra = {
                dollars = 3,
            }
        },
        loc_vars = function(self, info_queue, card)
            SynthB.song_info(info_queue, "you_wouldnt_know")
            return { vars = { card.ability.extra.dollars } }
        end,
        calculate = function(self, card, context)
            if context.press_play then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        for i = 1, #G.play.cards do
                            if G.play.cards[i].debuff then
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        G.play.cards[i]:juice_up()
                                        return true
                                    end,
                                }))
                                ease_dollars(card.ability.extra.dollars)
                                delay(0.23)
                            end
                        end
                        return true
                    end
                }))
                delay(0.4)
            end
            --[[if context.individual and context.cardarea == G.play and context.other_card.debuff then
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
                return {
                    dollars = card.ability.extra.dollars,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.dollar_buffer = 0
                                return true
                            end
                        }))
                    end
                }
            end]]
        end,
    }
    SynthB.inject_song_data {
        key = "you_wouldnt_know", -- related card's key without "j_modprefix_"
        prefix = "j_neonmod_",
        link = "https://www.youtube.com/watch?v=QyBLLBmxhRY",
        atlas = "neonmod_stillalive",
        pos = { x = 1, y = 0 } -- position on the atlas
    }
    -- Don't Say Goodbye
    --[[
    SMODS.Joker {
        key = "dont_say_goodbye",
        blueprint_compat = false,
        rarity = 3,
        cost = 8,
        atlas = "jonklers",
        pos = { x = 1, y = 6 },
        synthb_credits = {
            Artist = "ImaginaryNeon"
        },
        attributes = { "generation", "face", "Portal", "song", "Jonathan Coulton", "Ellen McClain", "GLaDOS" },
        config = {
            extra = {
                xmult = 1,
                xmult_gain = 0.5,
            }
        },
        loc_vars = function(self, info_queue, card)
            SynthB.song_info(info_queue, "dont_say_goodbye")
            return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult } }
        end,
        calculate = function(self, card, context)
            if context.remove_playing_cards and not context.blueprint then
                for _, removed_card in ipairs(context.removed) do
                    SMODS.add_card {
                        set = "Playing Card",                    -- For a random chance of being enhanced
                        key_append = "neonmod_you_wouldnt_know", -- Optional, key for randomization/pool checking
                        area = G.deck
                    }
                end
            end
            if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
                if context.beat_boss and card.ability.extra.xmult > 1 then
                    card.ability.extra.xmult = 1
                    return {
                        message = localize('k_reset'),
                        colour = G.C.RED
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
    SynthB.inject_song_data {
        key = "dont_say_goodbye", -- related card's key without "j_modprefix_"
        prefix = "j_neonmod_",
        link = "https://www.youtube.com/watch?v=1EbNoynFhjc",
        atlas = "neonmod_stillalive",
        pos = { x = 0, y = 0 } -- position on the atlas
    }]]

    --[[SynthB.Joker {
        key = "still_alive",
        loc_vars = function(self, info_queue, card)
            SynthB.song_info(info_queue, "still_alive")
        end,
        attributes = { "song", "Portal", "Jonathan Coulton", "Ellen McClain", "GLaDOS" }
    }]]
    SynthB.Character {
        key = "portalradio1",
        synthb_minor = {
            "j_neonmod_still_alive",
            "j_neonmod_want_you_gone",
            "j_neonmod_you_wouldnt_know"
        },
        synthb_major = {
            "j_neonmod_still_alive",
        },
        synthb_character = "portalradio",
        atlas = "synth",
        pos = { x = 0, y = 0 },
        config = {
            extra = {
                min_odds = 2,
                max_odds = 1,
                min_repeats = 1,
                max_repeats = 2,
            }
        },
        loc_vars = function(self, info_queue, card)
            local odds = SynthB.get_character_boosted_value(card, "odds") or 2
            local numerator, denominator = SMODS.get_probability_vars(card, 1, odds,
                'portalradio_synth')
            return { vars = { SynthB.get_character_loc_vars(card, "odds"), SynthB.get_character_loc_vars(card, "repeats"), numerator } }
        end,
        calculate = function(self, card, context)
            if context.repetition and (context.cardarea == G.play or context.cardarea == G.hand) then
                if context.other_card:get_id() == 8 or
                    context.other_card:get_id() == 5 or
                    context.other_card:get_id() == 2 then
                    if SMODS.pseudorandom_probability(card, 'portalradio_synth', 1, math.max(SynthB.get_character_boosted_value(card, "odds"), 1)) then
                        return {
                            repetitions = SynthB.get_character_boosted_value(card, "repeats")
                        }
                    end
                end
            end
        end
    }
    --table.insert(SynthB.banners.vs, Neonmod.neonbanner.neon)
    --[[
    Neonmod.neonbanner = {
        neon = {
            key = "synthb_gacha_neon",
            atlas = "neonmod_banners",
            pos = { x = 0, y = 0 },
            colours = {
                background1 = Neonmod.custom_colors.banners.neon.BACKGROUND,
                background2 = Neonmod.custom_colors.banners.neon.BACKGROUND2,
                ui = Neonmod.custom_colors.banners.neon.UI,
                particles = {
                    G.C.WHITE,
                    Neonmod.custom_colors.banners.neon.PARTICLES_1,
                    Neonmod.custom_colors.banners.neon.PARTICLES_2,
                    G.C.GOLD,
                }
            },
            pool = function()
                return "char_neonmod_portalradio1"
            end
        }
    }
    table.insert(SynthB.banners, Neonmod.neonbanner.neon)
    ]]
    --[[else
    SMODS.Joker {
        key = "still_alive",
        blueprint_compat = false,
        rarity = 3,
        cost = 7,
        atlas = "jonklers",
        pos = { x = 0, y = 6 },
        synthb_credits = {
            Artist = "ImaginaryNeon"
        },
        attributes = { "mult", "scaling", "reset", },
        config = {
            extra = {
                xmult = 1,
                xmult_gain = 0.5,
            }
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult } }
        end,
        calculate = function(self, card, context)
            if context.remove_playing_cards and not context.blueprint and not context.retrigger_joker then
                local fallen_cards = 0
                for _, removed_card in ipairs(context.removed) do
                    fallen_cards = fallen_cards + 1
                end
                if fallen_cards > 0 then
                    for _ = 1, fallen_cards do
                        SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = 'xmult',
                            scalar_value = 'xmult_gain',
                            no_message = true
                        })
                    end
                    return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } } }
                end
            end
            if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
                if context.beat_boss and card.ability.extra.xmult > 1 then
                    card.ability.extra.xmult = 1
                    return {
                        message = localize('k_reset'),
                        colour = G.C.RED
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
    SMODS.Joker {
        key = "want_you_gone",
        blueprint_compat = false,
        rarity = 3,
        cost = 8,
        atlas = "jonklers",
        pos = { x = 1, y = 6 },
        synthb_credits = {
            Artist = "ImaginaryNeon"
        },
        attributes = { "xmult", "scaling", "rank", "face", "destroy_card", "enhancements", },
        config = {
            extra = {
                xmult = 1,
                xmult_gain = 0.15,
            }
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult } }
        end,
        calculate = function(self, card, context)
            if context.destroy_card and not context.blueprint then
                if next(SMODS.get_enhancements(context.destroy_card)) and context.cardarea == G.play and not (context.destroy_card:is_face()) then
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = 'xmult',
                        scalar_value = 'xmult_gain',
                        no_message = true
                    })
                    return {
                        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                        colour = G.C.MULT,
                        remove = true
                    }
                end
                if context.joker_main then
                    return {
                        xmult = card.ability.extra.xmult
                    }
                end
            end
        end
    }
    SMODS.Joker {
        key = "you_wouldnt_know",
        blueprint_compat = false,
        rarity = 2,
        cost = 6,
        atlas = "jonklers",
        pos = { x = 2, y = 6 },
        pixel_size = { w = 70, h = 94 },
        synthb_credits = {
            Artist = "ImaginaryNeon"
        },
        attributes = { "economy", "boss_blind", },
        config = {
            extra = {
                dollars = 3,
            }
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.dollars } }
        end,
        calculate = function(self, card, context)
            if context.press_play then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        for i = 1, #G.play.cards do
                            if G.play.cards[i].debuff then
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        G.play.cards[i]:juice_up()
                                        return true
                                    end,
                                }))
                                ease_dollars(card.ability.extra.dollars)
                                delay(0.23)
                            end
                        end
                        return true
                    end
                }))
                delay(0.4)
            end
        end,
    }]]
end
