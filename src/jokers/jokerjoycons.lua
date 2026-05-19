SMODS.Joker {
    key = 'joyconl',
    atlas = 'jonklers',
    pos = {
        x = 4,
        y = 0
    },
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
        if context.joker_main then
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
    config = {
        extra = {
            mult = 0,
            change = 3,
            odds = 50,
        }
    },
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
        if context.joker_main then
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

SMODS.Joker {
    key = "passport",
    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    atlas = "jonklers",
    pos = { x = 1, y = 2 },
    pixel_size = { w = 71, h = 65 },
    config = { extra = { chips = 0, chip_mod = 12 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            local is_first_face = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_face() then
                    is_first_face = context.scoring_hand[i] == context.other_card
                    break
                end
            end
            if is_first_face then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS,
                    message_card = card
                }
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}
SMODS.Joker { -- commented out to avoid issues in the repo
    key = 'Wiimote',
    atlas = 'jonklers',
    pos = {
        x = 3,
        y = 0
    },
    rarity = 2,
    cost = 8,
    config = { extra = { timer = 0, positions_x = {}, positions_y = {}, speeds = {}, speed = 0, max_speed = 0, speed_scoring = 0, mult = 75 } },
    loc_vars = function(self, info_queue, card)
        local chips = card.ability.extra.mult * card.ability.extra.max_speed
        local fastness = math.floor(card.ability.extra.max_speed * 100) / 100
        if not fastness or not chips >= 0 then
            return { vars = { "Recalibrating...", "Recalibrating..." } }
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
        print("pos_X = " .. math.floor(G.CURSOR.T.x) .. ", pos_Y = " .. math.floor(G.CURSOR.T.y))
        print("v_X = " ..
            math.floor(((G.CURSOR.T.x or 0) - (oldpos.x or 0)) / ((#card.ability.extra.positions_x or 20) - 1) * 100) /
            100 ..
            ", v_Y = " ..
            math.floor(((G.CURSOR.T.y or 0) - (oldpos.y or 0)) / ((#card.ability.extra.positions_y or 20) - 1) * 100) /
            100)
        print("speed = " .. math.floor(card.ability.extra.speed * 1000) / 1000)
        print("Max Speed = " .. math.floor(card.ability.extra.max_speed * 1000) / 1000)
        print("Chips = " .. math.floor(card.ability.extra.max_speed * card.ability.extra.mult))
    end,
    calculate = function(self, card, context)
        if context.main then
            card.ability.extra.speed_scoring = math.floor((card.ability.extra.max_speed or 0) * 100) / 100
            return {
                chips = card.ability.extra.mult * card.ability.extra.speed_scoring
            }
        end
    end
}
