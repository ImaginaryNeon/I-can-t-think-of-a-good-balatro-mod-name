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
        attributes = { "mult", "Portal", "song", "Jonathan Coulton", "Ellen McClain", "GLaDOS" },
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
end
