SMODS.Joker {
    key = 'testobjectpleaseignore',
    atlas = 'jonklers',
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            chips = 150,
            mult = -4
        }
    },
    blueprint_compat = true,
    attributes = { 'chips', },
    rarity = 1,
    cost = 4,
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
    blueprint_compat = true,
    attributes = { 'retrigger', 'rank', 'two', 'five', 'eight' },
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
        chipsper = 0.75,
        chips = 0,
        other_key = nil }
    },
    attributes = { 'chips', 'mult', 'joker' },
    blueprint_compat = true,
    rarity = 1,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        if G.jokers then
            local other_joker = nil
            local tarname = nil
            local tardesc = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    if i < #G.jokers.cards then
                        other_joker = G.jokers.cards[i + 1]
                        card.ability.extra.other_key = other_joker.config.center.key
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
    update = function(self, card, dt)
        if JokerDisplay then
            if G.jokers and card.area == G.jokers then
                local other_joker = nil
                local tarname = nil
                local tardesc = nil
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == card then
                        if (i + 1) <= #G.jokers.cards then
                            other_joker = G.jokers.cards[i + 1]
                            if not (other_joker.config.center.key == card.ability.extra.other_key) then
                                local obj_key = other_joker.config.center.key
                                card.ability.extra.other_key = other_joker.config.center.key
                                local obj_set = other_joker.ability.set
                                tarname = localize { type = 'name_text', set = obj_set, key = obj_key }
                                tardesc = table.concat(
                                    localize({ type = 'raw_descriptions', key = obj_key, set = obj_set, vars = {} }), ' ')
                                card.ability.extra.mult = (string.len(tarname) or 0) * card.ability.extra.multper
                                card.ability.extra.chips = (string.len(tardesc) or 0) * card.ability.extra.chipsper
                            end
                        else
                            card.ability.extra.mult = 0
                            card.ability.extra.chips = 0
                        end
                    end
                end
            end
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local other_joker = nil
            local tarname = nil
            local tardesc = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    if (i + 1) <= #G.jokers.cards then
                        other_joker = G.jokers.cards[i + 1]
                        local obj_key = other_joker.config.center.key
                        local obj_set = other_joker.ability.set
                        tarname = localize { type = 'name_text', set = obj_set, key = obj_key }
                        tardesc = table.concat(
                            localize({ type = 'raw_descriptions', key = obj_key, set = obj_set, vars = {} }), ' ')
                        card.ability.extra.mult = (string.len(tarname) or 0) * card.ability.extra.multper
                        card.ability.extra.chips = (string.len(tardesc) or 0) * card.ability.extra.chipsper
                    else
                        card.ability.extra.mult = 0
                        card.ability.extra.chips = 0
                    end
                end
            end
            if card.ability.extra.mult > 0 or card.ability.extra.chips > 0 then
                return {
                    chips = card.ability.extra.chips,
                    mult = card.ability.extra.mult,
                }
            end
        end
    end
}


SMODS.Joker {
    key = 'cheatcode',
    atlas = 'jonklers',
    pos = {
        x = 5,
        y = 4
    },
    rarity = 1,
    cost = 4,
    config = {
        extra = {
            chips = 0,
            chipgain = 30,
            suits = {}, instruments = true
        }, immutable = { length = 4 }
    },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local suits = G.GAME.current_round.neonmod_cheatcode_cards and
            table.concat(G.GAME.current_round.neonmod_cheatcode_cards, ', ', 1, card.ability.immutable.length) or
            "Lamp, Oil, Rope, Bombs"
        card.ability.extra.suits = suits
        return {
            vars = { card.ability.extra.chipgain, card.ability.extra.chips, card.ability.immutable.length, suits },
        }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint and not (#G.hand.cards < card.ability.immutable.length) then
            local instrument = true
            for i = 1, math.floor(math.min(#G.hand.cards, card.ability.immutable.length)) do
                if G.hand.cards[i]:is_suit(G.GAME.current_round.neonmod_cheatcode_cards[i]) then
                else
                    instrument = false
                end
            end
            if instrument == true then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = 'chips',
                    scalar_value = 'chipgain',
                })
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

SMODS.Joker {
    key = 'stupendium',
    atlas = 'jonklers',
    pos = {
        x = 2,
        y = 3
    },
    config = { extra = { chips = 0, chip_gain = 1 } },
    attributes = { 'chips', 'scaling' },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_gain } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = 'chips',
                scalar_value = 'chip_gain',
            })
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
}
