SMODS.Joker {
    key = 'joyconl',
    atlas = 'jonklers',
    pos = {
        x = 4,
        y = 0
    },
    perishable_compat = false,
    demicoloncompat = true,
    rarity = 2,
    cost = 6,
    config = {
        extra = {
            chips = 0,
            change = 5
        }
    },
    pixel_size = { w = 23, h = 47 },
    loc_vars = function(self, info_queue, card)
        do
            return {
                vars = {
                    card.ability.extra.chips,
                    card.ability.extra.change,
                },
            }
        end
        if card.area and card.area == G.jokers then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
        end
    end,
    calculate = function(self, card, context)
        local other_joker = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
        end
        if context.post_trigger and context.other_card == other_joker then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = 'chips',
                scalar_value = 'change',
                message_colour = G.C.ATTENTION
            })
        end
        if context.joker_main or context.forcetrigger then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}
SMODS.Joker {
    key = 'joyconr',
    atlas = 'jonklers',
    pos = {
        x = 5,
        y = 0
    },
    pixel_size = { w = 24, h = 47 },
    rarity = 2,
    cost = 6,
    perishable_compat = false,
    demicoloncompat = true,
    config = {
        extra = {
            mult = 0,
            change = 2,
            odds = 50,
        }
    },
    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i + 1] == card then other_joker = G.jokers.cards[i] end
            end
        end
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'neonmod_joyconr')
        return { vars = { card.ability.extra.mult, card.ability.extra.change, numerator, denominator } }
    end,
    block_overrides = {
        value = true,  -- blocks modifications to the ref_value
        scalar = true, -- blocks modifications to the scalar_value
        message = true -- blocks modifications to the scaling_message
    },
    calculate = function(self, card, context)
        local other_joker = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i + 1] == card then other_joker = G.jokers.cards[i] end
        end
        if context.post_trigger and context.other_card == other_joker then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = 'mult',
                scalar_value = 'change',
                message_colour = G.C.ATTENTION
            })
        end
        if context.joker_main or context.forcetrigger then
            return {
                mult = card.ability.extra.mult

            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'neonmod_joyconr', 1, card.ability.extra.odds) then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = 'Broken!'
                }
            end
        end
    end
}

local function reset_neonmod_cheatcode()
    G.GAME.current_round.neonmod_cheatcode_cards = G.GAME.current_round.neonmod_cheatcode_cards or
        { 'Hearts', 'Diamonds', 'Spades', 'Clubs', 'Hearts', 'Diamonds', 'Spades', 'Clubs', 'Hearts', 'Spades' }
    for i = 1, 10 do
        local ancient_card = pseudorandom_element(SMODS.Suits, 'neonmod_konamicode' .. G.GAME.round_resets.ante)
        G.GAME.current_round.neonmod_cheatcode_cards[i] = ancient_card.key
    end
end

local function get_jokers_sorted_by_usage() -- thanks srockw
    local jokers = {}
    G.GAME.current_round.neonmod_min_uses = G.GAME.current_round.neonmod_min_uses or 0
    for _, v in pairs(G.P_CENTER_POOLS.Joker) do
        jokers[#jokers + 1] = {
            key = v.key,
            count = (G.PROFILES[G.SETTINGS.profile].joker_usage[v.key] or {}).count or 0
        }
    end
    table.sort(jokers, function(a, b)
        return a.count > b.count
    end)
    G.GAME.current_round.neonmod_min_uses = jokers[15].count or 0
    return jokers
end

local function piss_in_the_water_supply() -- based on prior function
    local wings = {}
    G.GAME.current_round.neonmod_bighandthing = G.GAME.current_round.neonmod_bighandthing or 0
    --print("test start")
    for _, v in pairs(SMODS.PokerHands) do
        wings[#wings + 1] = {
            key = v.key:gsub("%s+", ""), -- we need to kill john localthunk
            count = (G.PROFILES[G.SETTINGS.profile].hand_usage[v.key:gsub("%s+", "")] or {}).count or 0,
            name = localize(v.key, 'poker_hands'),
        }
    end
    table.sort(wings, function(a, b)
        return a.count > b.count
    end)
    G.GAME.current_round.neonmod_bighandthing = wings[1].name or "Go fuck yourself"
    --print(wings)
    return wings
end

function SMODS.current_mod.reset_game_globals(run_start)
    reset_neonmod_cheatcode()
    get_jokers_sorted_by_usage()
    piss_in_the_water_supply()
end

SMODS.Joker {
    key = "passport",
    blueprint_compat = true,
    perishable_compat = false,
    demicoloncompat = true,
    rarity = 1,
    cost = 5,
    atlas = "jonklers",
    pos = { x = 1, y = 2 },
    pixel_size = { w = 71, h = 65 },
    config = { extra = { chips = 0, chip_mod = 6 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_face() and not context.blueprint then
            local is_first_face = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_face() then
                    is_first_face = context.scoring_hand[i] == context.other_card
                    break
                end
            end
            if is_first_face then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = 'chips',
                    scalar_value = 'chip_mod',
                })
            end
        end
        if context.joker_main or context.forcetrigger then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

SMODS.Joker { -- To-do: fix chip message
    key = 'Wiimote',
    atlas = 'jonklers',
    pos = {
        x = 3,
        y = 0
    },
    blueprint_compat = true,
    demicoloncompat = false,
    rarity = 1,
    cost = 5,
    config = { extra = { timer = 0, positions_x = {}, positions_y = {}, speeds = {}, speed = 0, max_speed = 0, speed_scoring = 0, mult = 75 } },
    loc_vars = function(self, info_queue, card)
        local chips = card.ability.extra.mult * card.ability.extra.max_speed
        local fastness = math.floor(card.ability.extra.max_speed * 100) / 100
        if not fastness or not (chips > 0) then
            return { vars = { "0", "Recalibrating..." } }
        else
            return { vars = { chips, fastness } }
        end
    end,
    update = function(self, card, dt)
        card.ability.extra.timer = (card.ability.extra.timer or 0) + dt
        local mousepos = {}
        mousepos.x, mousepos.y = G.CURSOR.T.x, G.CURSOR.T.y
        local oldpos = {}
        table.insert(card.ability.extra.positions_x, mousepos.x)
        table.insert(card.ability.extra.positions_y, mousepos.y)
        oldpos.x = card.ability.extra.positions_x[1]
        if #card.ability.extra.positions_x >= 20 then
            table.remove(card.ability.extra.positions_x, 1)
        end
        oldpos.y = card.ability.extra.positions_y[1]
        if #card.ability.extra.positions_y >= 20 then
            table.remove(card.ability.extra.positions_y, 1)
        end
        --        print(mousepos.x, oldpos.x)
        card.ability.extra.speed = math.floor(math.sqrt(((((G.CURSOR.T.x or 0) - (oldpos.x or 0)) / ((#card.ability.extra.positions_x or 20) - 1)) ^
                    2)
                + ((((G.CURSOR.T.y or 0) - (oldpos.y or 0)) / ((#card.ability.extra.positions_y or 20) - 1)) ^ 2)) * 100) /
            100
        table.insert(card.ability.extra.speeds, card.ability.extra.speed)
        if #card.ability.extra.speeds >= 300 then
            table.remove(card.ability.extra.speeds, 1)
        end
        local value = 1
        if #card.ability.extra.speeds > 0 then
            for i = 1, #card.ability.extra.speeds do
                if (card.ability.extra.speeds[value] < card.ability.extra.speeds[i]) then
                    value = i
                end
                card.ability.extra.max_speed = card.ability.extra.speeds[value]
            end
        end
        --[[print("pos_X = " .. math.floor(G.CURSOR.T.x) .. ", pos_Y = " .. math.floor(G.CURSOR.T.y))
        print("v_X = " ..
            math.floor(((G.CURSOR.T.x or 0) - (oldpos.x or 0)) / ((#card.ability.extra.positions_x or 20) - 1) * 100) /
            100 ..
            ", v_Y = " ..
            math.floor(((G.CURSOR.T.y or 0) - (oldpos.y or 0)) / ((#card.ability.extra.positions_y or 20) - 1) * 100) /
            100)
        print("speed = " .. math.floor(card.ability.extra.speed * 1000) / 1000)
        print("Max Speed = " .. math.floor(card.ability.extra.max_speed * 1000) / 1000)
        print("Chips = " .. math.floor(card.ability.extra.max_speed * card.ability.extra.mult))]]
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.speed_scoring = math.floor((card.ability.extra.max_speed or 0) * 100) / 100
            return {
                chips = card.ability.extra.mult * card.ability.extra.speed_scoring
            }
        end
    end
}

local https = require "SMODS.https"
--if https then
SMODS.Joker {
    key = "teambuilder",
    blueprint_compat = true,
    demicoloncompat = true,
    rarity = 2,
    cost = 9,
    atlas = "jonklers",
    pos = { x = 2, y = 8 },
    config = { immutable = { elo = 1000, fallbackchips = 294 } },
    loc_vars = function(self, info_queue, card)
        if card.ability.immutable.elo == 1000 or card.ability.immutable.elo == (1000 + card.ability.immutable.fallbackchips) then
            local statuscode, body = https.request("https://pokemonshowdown.com/users/ImaginaryNeon")
            if statuscode == 200 then
                --print("yeah, we good")
                local i, j = string.find(tostring(body), "gen9ou<") --<tr><td>gen9ou</td><td style="text-align:center"><strong>1294</strong>
                --print(j) -- j+42?
                --print(string.sub(tostring(body), j + 43, j + 46))
                card.ability.immutable.elo = tonumber(string.sub(tostring(body), j + 43, j + 46))
                return { vars = { card.ability.immutable.elo, card.ability.immutable.fallbackchips } }
            else
                return { vars = { "Connect to wifi, dumbass" } }
            end
        else
            return { vars = { card.ability.immutable.elo, card.ability.immutable.fallbackchips } }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        local statuscode, body = https.request("https://pokemonshowdown.com/users/ImaginaryNeon")
        if statuscode == 200 then
            --print("yeah, we good")
            local i, j = string.find(tostring(body), "gen9ou<") --<tr><td>gen9ou</td><td style="text-align:center"><strong>1294</strong>
            --print(j) -- j+42?
            --print(string.sub(tostring(body), j + 43, j + 46))
            card.ability.immutable.elo = tonumber(string.sub(tostring(body), j + 43, j + 46))
        else
            card.ability.immutable.elo = card.ability.immutable.fallbackchips + 1000
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            --[[string.find("2", "hello")--]]
            --print(https.request("https://pokemonshowdown.com/users/ImaginaryNeon", "GET /html/body/div[3]/div/div/table/tbody/tr[19]/td[2]/strong"))
            --print(https.request("https://pokemonshowdown.com/users/ImaginaryNeon"))
            --print("help")
            local statuscode, body = https.request("https://pokemonshowdown.com/users/ImaginaryNeon")
            if statuscode == 200 then
                --print("yeah, we good")
                local i, j = string.find(tostring(body), "gen9ou<") --<tr><td>gen9ou</td><td style="text-align:center"><strong>1294</strong>
                --print(j) -- j+42?
                --print(string.sub(tostring(body), j + 43, j + 46))
                card.ability.immutable.elo = tonumber(string.sub(tostring(body), j + 43, j + 46))
                if card.ability.immutable.elo >= 1000 then
                    return {
                        chips = card.ability.immutable.elo - 1000
                    }
                else
                    print("something fucked up on the concept of a number's end")
                    return {
                        chips = card.ability.immutable.fallbackchips
                    }
                end
            else
                print("something fucked up on the site's end")
                return {
                    chips = card.ability.immutable.fallbackchips
                }
            end
        end
    end
}

SMODS.Joker {
    key = "amiibo",
    blueprint_compat = true,
    perishable_compat = false,
    demicoloncompat = true,
    rarity = 1,
    cost = 5,
    atlas = "jonklers",
    pos = { x = 3, y = 8 },
    pixel_size = { w = 51, h = 76 },
    config = { extra = { mult = 0, mult_gain = 8 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,
    calculate = function(self, card, context)
        if context.destroy_card then
            if context.cardarea == G.play and SMODS.has_enhancement(context.destroy_card, "m_stone") then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = 'mult',
                    scalar_value = 'mult_gain',
                    message_colour = G.C.ATTENTION
                })
                return { remove = true }
            end
        end
        if context.joker_main or context.forcetrigger then
            if card.ability.extra.mult > 0 then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}
