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

SMODS.Joker {
    key = "wishiwashi",
    atlas = 'jonklers',
    rarity = 1,
    cost = 6,
    pos = { x = 3, y = 9 },
    pixel_size = { w = 20, h = 26 },
    --display_size = { w = 14 * 1.5, h = 18 * 1.5 },
    blueprint_compat = false,
    demicoloncompat = true,
    config = { extra = { odds = 4, } },
    loc_vars = function(self, info_queue, card)
        --info_queue[#info_queue + 1] = { key = 'tag_double', set = 'Tag' }
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'neonmod_wishiwashi')
        return { vars = { numerator, denominator, --[[localize { type = 'name_text', set = 'Tag', key = 'tag_double' }--]] } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
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
    cost = 6,
    pos = { x = 0, y = 9 },
    pixel_size = { w = 49, h = 70 },
    display_size = { w = 49 * 1.2, h = 70 * 1.2 },
    blueprint_compat = true,
    demicoloncompat = true,
    config = { extra = { odds = 4, } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.j_joker
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'neonmod_schoolform')
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            if context.other_card:get_id() == 14 and SMODS.pseudorandom_probability(card, 'neonmod_wishiwashi', 1, card.ability.extra.odds) then
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                return {
                    extra = {
                        message = localize('k_plus_joker'),
                        colour = G.C.BLUE,
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = (function()
                                    local random_edition = SMODS.poll_edition { key = "jokijoshi", guaranteed = true, no_negative = true }
                                    SMODS.add_card { set = "Joker", key = 'j_joker', edition = random_edition }
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
