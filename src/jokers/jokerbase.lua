SMODS.Joker {
    key = 'testobjectpleaseignore',
    atlas = 'jonklers',
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            chips = 200,
            mult = -5
        }
    },
    rarity = 1,
    cost = 2,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
            }
        end
    end
}

SMODS.Joker {
    key = 'portalradio',
    atlas = 'jonklers',
    pos = {
        x = 1,
        y = 0
    },
    config = {
        extra = {
            repetitions = 1,
        }
    },
    rarity = 2,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.repetitions
            }
        }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card:get_id() == 8 or
                context.other_card:get_id() == 5 or
                context.other_card:get_id() == 2 then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end
}


-- loosely based off of Hot Potato's "Yapper"
SMODS.Joker {
    key = 'loremipsum',
    atlas = 'jonklers',
    pos = {
        x = 0,
        y = 2
    },
    config = { extra = {
        multper = 1,
        mult = 0,
        chipsper = 1,
        chips = 0, }
    },
    rarity = 1,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        if G.jokers then
            local other_joker = nil
            local tarname = nil
            local tardesc = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    if i < #G.jokers.cards then
                        other_joker = G.jokers.cards[i + 1]
                        local obj_key = other_joker.config.center.key
                        local obj_set = other_joker.ability.set
                        tarname = localize { type = 'name_text', set = obj_set, key = obj_key }
                        tardesc = table.concat(
                            localize({ type = 'raw_descriptions', key = obj_key, set = obj_set, vars = {} }), ' ')
                        card.ability.extra.mult = (string.len(tarname) or 0) * card.ability.extra.multper
                        card.ability.extra.chips = (string.len(tardesc) or 0) * card.ability.extra.chipsper
                    end
                end
            end
        end
        return { vars = { card.ability.extra.multper, card.ability.extra.mult, card.ability.extra.chipsper, card.ability.extra.chips } --, string.len(card.ability.current) * card.ability.amxt}
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local other_joker = nil
            local tarname = nil
            local tardesc = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    if i < #G.jokers.cards then
                        other_joker = G.jokers.cards[i + 1]
                        local obj_key = other_joker.config.center.key
                        local obj_set = other_joker.ability.set
                        tarname = localize { type = 'name_text', set = obj_set, key = obj_key }
                        tardesc = table.concat(
                            localize({ type = 'raw_descriptions', key = obj_key, set = obj_set, vars = {} }), ' ') -- thanks eggymari
                        card.ability.extra.mult = (string.len(tarname) or 0) * card.ability.extra.multper
                        card.ability.extra.chips = (string.len(tardesc) or 0) * card.ability.extra.chipsper
                    end
                end
            end
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
            }
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
