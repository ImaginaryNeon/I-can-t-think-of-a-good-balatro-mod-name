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
        if context.joker_main or context.forcetrigger then
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
    demicoloncompat = false,
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
    demicoloncompat = true,
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
        if context.joker_main or context.forcetrigger then
            if not context.blueprint then
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
    perishable_compat = false,
    demicoloncompat = true,
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
        if context.joker_main or context.forcetrigger then
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
    config = { extra = { chips = 0, chip_gain = 1 },
        immutable = { lyrics = { "Life is a drag, life is a chore", "Frightfully sad, so mindless a bore", "Mice in a bag, you fight and you gnaw",
            "For the rights just to brag in the line for the door", "And the higher your score, the louder you bicker", "Life gave you lemons?", "Good heavens, you're bitter",
            "And whatever you get to collect", "Well, that head interjects", "With incessant effect", "\"Could be bigger!\"", "Here comes the next utter wreck",
            "What the heck? Cut the deck", "Unsuspectingly betting their dinner", "When left unchecked, cuts a check", "Bust, the rest rubberneck",
            "But expect still to end up a winner", "If you're ever in the dumps or feeling stuck in a rut", "You simply haven't had the fun", "Of watching number go up",
            "You know it's wonderful stuff", "Let the hundreds runneth over your cup", "It's such a buzz to watch the number go up", "You must be pretty dumb",
            "For thinking some is enough", "When you can add another one", "And make the number go up", "Until you run out of luck", "And find your funds are down to nothing but fluff",
            "No runners-up in making number go up.", "That day-to-day is unbearably dry", "Makes sense to chase that numerical high", "Be it a salary, calories, boxes on ballot sheets", "Whoops, don't forget to subscribe!", "Are you feeling alive?", "With catharsis or pride?", "Maybe father has cried?",
            "Have you asked yourself why?", "To blast through a ceiling might pass for appealing", "But chance is you're leaving with plaster in eyes",
            "And the faster the rise, the harder the fall", "Infinite jesters still get curtain calls", "My god, it's historic, meteoric!",
            "Alas, my poor Yorick", "He held his head high through it all", "If you're ever in the dumps", "Or feeling stuck in a rut", "You simply haven't had the fun",
            "Of watching number go up", "If your budget is bust", "You gotta trust the funds are gonna erupt", "You've gotta lust for making numbers go up",
            "(Haha, sing, you fools!)", "You must be pretty dumb", "For thinking some is enough", "When you can add another one", "And make the number go up",
            "But all the luster can rust", "Sweep your dreams into a dustpan and brush", "Another shmuck to make the numbers go up",
            "Shoot like a star or fold like a quitter", "Somebody once told me about all that glitters", "Now you might dream of Queens", "Straight Flush with the green",
            "But get Jack when you're sold down the river", "You might find you're an Ace", "Or just bluff from the start", "Have diamonds in spades",
            "Or get clubbed in the heart", "When the pot's at an end", "And the flop doesn't send", "You a hand full of lovely cards", "The world's at the table, it's prudent to play",
            "To err, says the fable, is human, but hey", "Watch your stack", "For the fact is that affluence turning to crap",
            "Is one little vowel movement away", "Those rags to riches you got from that tip-off", "Just tacking stitches to viciously rip off",
            "Bet on a dream and it seems", "It might tear at the seams", "Why'd you think so much poker is strip-off?", "Now let's see who's next in line to proclaim",
            "They can be king just by making it reign", "A million monarchs competing", "For dwindling court seating", "All blind to how fleeting their fame",
            "The ante is up, and the cards are face-down", "Sadly, it can't be the other way 'round", "But the biggest of figuress won't impress the digger",
            "When picking your hole in the ground", "(Oh, now you're in the hole!)", "If you're ever in the dumps or feeling stuck in a rut", "You simply haven't had the fun",
            "Of watching number go up", "Oh, it's a punch in the nuts", "Stuck in a puddle with the wrong kind of flush", "Get off your butt and make the number go up",
            "(Hahaha, yes!)", "You must be pretty dumb", "For thinking some is enough", "When you can add another one", "And make the number go up",
            "(So I can hear you in the bluffing tables!)", "Until it crumbles to dust", "Another puppet for the vultures to pluck", "Outta luck, making number go up.",
            "Yeah, we'd really like to make another couple of bucks", "So, won't you play the song again", "And make the number go up?" }, position = 0 } },
    attributes = { 'chips', 'scaling' },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    perishable_compat = false,
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_gain } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = 'chips',
                scalar_value = 'chip_gain',
                scaling_message = {
                    message = card.ability.immutable.lyrics
                        [(card.ability.immutable.position % #card.ability.immutable.lyrics) + 1],
                    colour = G.C.BLUE
                }
            })
            card.ability.immutable.position = (card.ability.immutable.position or 0) + 1
        end
        if context.joker_main or context.forcetrigger then
            --local pos = (card.ability.immutable.position % #card.ability.immutable.lyrics) + 1
            --card.ability.immutable.position = (card.ability.immutable.position or 0) + 1
            return {
                chips = card.ability.extra.chips,
                --message = card.ability.immutable.lyrics[pos],
            }
        end
    end,
}
