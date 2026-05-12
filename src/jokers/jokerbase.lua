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
-- loosely based off of Hot Potato's "Yapper"
SMODS.Joker {
    key = 'loremipsum',
    atlas = 'jonklers',
    pos = {
        x = 0,
        y = 2
    },
    config = {
        multper = 1,
        mult = 0,
        chipsper = 1,
        chips = 0,
    },
    rarity = 1,
    cost = 2,
    loc_vars = function (self, info_queue, card)
        if G.jokers then
            local other_joker = nil
            local tarname = nil
            local tardesc = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
            if not other_joker == nil then
                local obj_key = other_joker.config.center.key
                local obj_set = other_joker.ability.set
                tarname = localize { type = 'name_text', set = obj_set, key = obj_key }
                tardesc = localize { type = 'name_text', set = obj_set, key = obj_key } -- find a way to turn a desc table into a string. Maybe to_string(G.localization.descriptions[self.set][self.key] = desc_target)?
                card.ability.mult = (string.len(tarname) or 0) * card.ability.multper
                card.ability.chips = (string.len(tardesc) or 0) * card.ability.chipsper
            end
        end
        return { vars = { card.ability.multper, card.ability.mult, card.ability.chipsper, card.ability.chips } --, string.len(card.ability.current) * card.ability.amt}
        }
    end,
    calculate = function(self, card, context)
        local other_joker = nil
        local tarname = nil
        local tardesc = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
        end
        if not other_joker == nil then
            local obj_key = other_joker.config.center.key
            local obj_set = other_joker.ability.set
            tarname = localize { type = 'name_text', set = obj_set, key = obj_key }
            tardesc = localize { type = 'name_text', set = obj_set, key = obj_key } -- find a way to turn a desc table into a string. Maybe to_string(G.localization.descriptions[self.set][self.key] = desc_target)?
            card.ability.mult = (string.len(tarname) or 0) * card.ability.multper
            card.ability.chips = (string.len(tardesc) or 0) * card.ability.chipsper
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
            }
        end
    end
}
