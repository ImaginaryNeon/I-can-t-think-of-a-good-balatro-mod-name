--if context.pseudorandom_result and not context.result
SMODS.Joker {
    key = "tomodachipaper",
    atlas = 'jonklers',
    rarity = 1,
    cost = 5,
    pos = { x = 4, y = 8 },
    pixel_size = { w = 52, h = 48 },
    blueprint_compat = true,
    demicoloncompat = true,
    config = { extra = { dollars = 1, } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if (context.pseudorandom_result and not context.result) or context.forcetrigger then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
            return {
                dollars = card.ability.extra.dollars,
                func = function() -- This is for timing purposes, this goes after the dollar modification
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
    end
}

SMODS.Joker { -- Hands start with 999 Chips and 99 Mult, unless current Chips/Mult is greater
    key = "emesis",
    rarity = 3,
    atlas = 'jonklers2',
    pos = { x = 2, y = 0 },
    pixel_size = { w = 51, h = 82 },
    cost = 9,
    --discovered = false,
    blueprint_compat = false,
    demicoloncompat = false,
    --attributes = { 'joker' },
    config = {
        extra = {
            storedchips = 0,
        },
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.storedchips } }
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        --if context.before and G.GAME.current_round.hands_played == 0 then
        if context.final_scoring_step and not context.blueprint and G.GAME.current_round.hands_played <= 0 then
            if SMODS.calculate_round_score() > G.GAME.blind.chips then
                card.ability.extra.storedchips = (card.ability.extra.storedchips or 0) +
                    (SMODS.calculate_round_score() / 2)
                return {
                    score = -(SMODS.calculate_round_score() / 2),
                    no_message = true
                }
            end
        end
        if context.end_of_round and context.game_over and context.main_eval then
            if (G.GAME.blind.chips - G.GAME.chips) <= card.ability.extra.storedchips then -- See note about Talisman compatibility on the wiki
                local list = { "ph_emesis_msg1", "ph_emesis_msg2", "ph_emesis_msg3", "ph_emesis_msg4", "ph_emesis_msg5",
                    "ph_emesis_msg6" }
                local random_element = pseudorandom_element(list, "emesis_blue" .. G.GAME.round_resets.ante)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')
                        card.ability.extra.storedchips = 0
                        return true
                    end
                }))
                return {
                    message = localize('k_reset'),
                    saved = random_element,
                    colour = G.C.RED
                }
            end
        end
    end,
}

SMODS.Joker { -- Hands start with 999 Chips and 99 Mult, unless current Chips/Mult is greater
    key = "photochad",
    rarity = 3,
    atlas = 'jonklers2',
    pos = { x = 4, y = 0 },
    cost = 9,
    --discovered = false,
    blueprint_compat = true,
    demicoloncompat = true,
    attributes = { 'xmult' },
    config = { extra = { xmult = 2, }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            -- add a triggered flag (unique to your mod)
            context.other_card.ability.neonmod_playingcard_triggered = (context.other_card.ability.neonmod_playingcard_triggered or false)
            if context.other_card.ability.neonmod_playingcard_triggered == true then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
            context.other_card.ability.neonmod_playingcard_triggered = true
        end
        if context.joker_main and not context.blueprint then
            for i = 1, #G.play.cards do
                G.play.cards[i].ability.neonmod_playingcard_triggered = false
            end
        end
        if context.forcetrigger then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}

SMODS.Joker {
    key = "wishiwashi",
    atlas = 'jonklers',
    rarity = 2,
    cost = 8,
    pos = { x = 3, y = 9 },
    pixel_size = { w = 20, h = 26 },
    --display_size = { w = 14 * 1.5, h = 18 * 1.5 },
    blueprint_compat = true,
    demicoloncompat = true,
    config = { extra = { odds = 4, } },
    loc_vars = function(self, info_queue, card)
        --info_queue[#info_queue + 1] = { key = 'tag_double', set = 'Tag' }
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'neonmod_wishiwashi')
        return { vars = { numerator, denominator, --[[localize { type = 'name_text', set = 'Tag', key = 'tag_double' }--]] } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play --[[and not context.blueprint--]] then
            if (context.other_card:get_id() == 14) and SMODS.pseudorandom_probability(card, 'neonmod_wishiwashi', 1, card.ability.extra.odds) then
                local tag_pool = get_current_pool('Tag')
                local selected_tag = pseudorandom_element(tag_pool, 'neonmod_tag_get')
                local it = 1
                while selected_tag == 'UNAVAILABLE' do
                    it = it + 1
                    selected_tag = pseudorandom_element(tag_pool, 'neonmod_tag_get2' .. it)
                end
                --[[
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        add_tag({ key = 'tag_double' })
                        play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                        return true
                    end)
                }))--]]
                return nil, true
            end
        end
        if context.after and not context.blueprint then
            if ((G.GAME.chips + SMODS.calculate_round_score()) / G.GAME.blind.chips >= 0.25) and not ((G.GAME.chips + SMODS.calculate_round_score()) > G.GAME.blind.chips) then
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        card:set_ability("j_neonmod_schoolform")
                        return true
                    end)
                }))
            end
        end
    end
}

SMODS.Joker {
    key = "schoolform",
    atlas = 'jonklers',
    rarity = 3,
    cost = 8,
    pos = { x = 0, y = 9 },
    pixel_size = { w = 49, h = 70 },
    display_size = { w = 49 * 1.2, h = 70 * 1.2 },
    pronouns = "they_them",
    blueprint_compat = true,
    demicoloncompat = true,
    no_collection = true,
    config = { extra = { odds = 4, } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.j_joker
        if not self.edition or (self.edition and not self.edition.negative) then
            info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        end
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'neonmod_schoolform')
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then --[[and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then--]]
            if context.other_card:get_id() == 14 and SMODS.pseudorandom_probability(card, 'neonmod_wishiwashi', 1, card.ability.extra.odds) then
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                return {
                    extra = {
                        message = localize('k_plus_joker'),
                        colour = G.C.BLUE,
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = (function()
                                    --local random_edition = SMODS.poll_edition { key = "jokijoshi", guaranteed = true, } --no_negative = true }
                                    SMODS.add_card { set = "Joker", key = 'j_joker', edition = "e_negative" --[[random_edition]] }
                                    G.GAME.joker_buffer = 0
                                    return true
                                end)
                            }))
                        end
                    },
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card:set_ability("j_neonmod_wishiwashi")
        end
    end,
    in_pool = function(self, args) return false end
}
