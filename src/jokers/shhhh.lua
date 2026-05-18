if Cryptid and Mannlatro then
    SMODS.Joker {
        key = "secret",
        rarity = "cry_exotic",
        cost = 9999,
        --no_collection = true,
        atlas = "jonklers",
        pos = { x = 0, y = 0 },
        config = { extra = { xmult = 20, position = 0, lines = { "Here's a little lesson in trickery.", "This is going down in history.", "If you wanna be a Villain Number One,", "You have to chase a superhero on the run!", "Just follow my moves, and sneak around.", "Be careful not to make a sound!", "(Shh!)", "(No, don't touch that!)", "We are Number One!", "Hey!", "We are Number One!", "We are Number One!", "Hahaha!", "Now look at this net, that I just found.", "When I say go, be ready to throw.", "Go!", "Throw it on him, not me!", "Ugh, let's try something else!", "Now watch and learn, here's the deal!", "He'll slip and slide on this banana peel!", "(Ha ha ha, gasp! what are you doing!?)", "Ba-ba-biddly-ba-ba-ba-ba,", "Ba-ba-ba-ba-ba-ba-ba!", "We are Number One!", "Hey!" --[[]], "Ba-ba-biddly-ba-ba-ba-ba,", "Ba-ba-ba-ba-ba-ba-ba!", "We are Number One!", "Ba-ba-biddly-ba-ba-ba-ba,", "Ba-ba-ba-ba-ba-ba-ba!", "We are Number One!", "Hey!", "Ba-ba-biddly-ba-ba-ba-ba,", "Ba-ba-ba-ba-ba-ba-ba!", "We are Number One!", "Hey!", "Hey!", --[[loop]] } } },
        loc_vars = function(self, info_queue, card)
            local piss = card.ability.extra.lines[2]
            return { vars = { card.ability.extra.xmult } }
        end,
        calculate = function(self, card, context)
            if context.before and card.ability.extra.position == 0 then
                return {
                    message = "Now, listen closely."
                }
            end
            if context.individual and context.cardarea == G.play then
                card.ability.extra.position = card.ability.extra.position + 1
                if card.ability.extra.position <= 20 then
                    return {
                        message = card.ability.extra.lines[card.ability.extra.position],
                        xmult = 20
                    }
                end
                if card.ability.extra.position == 20 then -- banana peel
                    if G.GAME.pool_flags.gros_michel_extinct == true then
                        SMODS.add_card { set = 'Joker', key = "j_cavendish", edition = 'e_negative' }
                    else
                        SMODS.add_card { set = 'Joker', key = "j_gros_michel", edition = 'e_negative' }
                    end
                    return {
                        message = card.ability.extra.lines[card.ability.extra.position],
                    }
                end
                if card.ability.extra.position == 21 then -- what are you doing
                    if next(SMODS.find_card("j_gros_michel")) or next(SMODS.find_card("j_cavendish")) then
                        -- do code
                        for i = 1, #G.jokers.cards do
                            if G.jokers.cards[i].key == "j_gros_michel" or G.jokers.cards[i].key == "j_cavendish" then
                                SMODS.destroy_cards(G.jokers.cards[i])
                            end
                        end
                        G.GAME.pool_flags.gros_michel_extinct = true
                    end
                    return {
                        message = card.ability.extra.lines[card.ability.extra.position],
                    }
                end

                if card.ability.extra.position >= 21 and card.ability.extra.position <= 36 then -- rest
                    return {
                        message = card.ability.extra.lines[card.ability.extra.position],
                    }
                end
                if card.ability.extra.position >= 37 then -- failsafe
                    card.ability.extra.position = 0
                    return {
                        message = card.ability.extra.lines[37],
                    }
                end
            end

            if context.individual and context.cardarea == G.play and context.other_card == context.scoring_hand[3] then
                return {
                    message = "This is going down in history.",
                    xmult = 20
                }
            end
            if context.main then
                return {
                    xmult = 20
                }
            end
        end,
        in_pool = function(self, args) return false end
    }
end
