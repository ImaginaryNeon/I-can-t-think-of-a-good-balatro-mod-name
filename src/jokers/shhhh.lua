if Cryptid and Mannlatro then
    SMODS.Joker {
        key = "secret",
        rarity = "cry_exotic",
        cost = 50,
        --no_collection = true,
        atlas = "jonklers",
        pos = { x = 0, y = 0 },
        config = { extra = { xmult = 20, position = 0, lines = { "Here's a little lesson in trickery.", "This is going down in history.", "If you wanna be a Villain Number One,", "You have to chase a superhero on the run!", "Just follow my moves, and sneak around.", "Be careful not to make a sound!", "(Shh!)", "(No, don't touch that!)", "We are Number One!", "Hey!", "We are Number One!", "We are Number One!", "Hahaha!", "Now look at this net, that I just found.", "When I say go, be ready to throw.", "Go!", "Throw it on him, not me!", "Ugh, let's try something else!", "Now watch and learn, here's the deal!", "He'll slip and slide on this banana peel!", "(Ha ha ha, gasp! what are you doing!?)", "Ba-ba-biddly-ba-ba-ba-ba,", "Ba-ba-ba-ba-ba-ba-ba!", "We are Number One!", "Hey!" --[[]], "Ba-ba-biddly-ba-ba-ba-ba,", "Ba-ba-ba-ba-ba-ba-ba!", "We are Number One!", "Ba-ba-biddly-ba-ba-ba-ba,", "Ba-ba-ba-ba-ba-ba-ba!", "We are Number One!", "Hey!", "Ba-ba-biddly-ba-ba-ba-ba,", "Ba-ba-ba-ba-ba-ba-ba!", "We are Number One!", "Hey!", "Hey!", --[[loop]] "Hey!", "We are Number One", "Hey!", "We are Number One" } } },
        loc_vars = function(self, info_queue, card)
            local piss = card.ability.extra.lines[2]
            return { vars = { card.ability.extra.xmult } }
        end,
        calculate = function(self, card, context)
            if context.before and card.ability.extra.position == 0 then
                return {
                    message = "Are you, uh, a real villain?",
                    colour = G.C.SUITS.Spades,
                    message_card = card,
                    message = "Well, uh, technically... nah.",
                    colour = G.C.PURPLE,
                    message_card = card,
                    message = "Have you ever caught a good guy, like, uh, like a real superhero?",
                    colour = G.C.SUITS.Spades,
                    message_card = card,
                    message = "Nah.",
                    colour = G.C.PURPLE,
                    message_card = card,
                    message = "Have you ever tried a disguise?",
                    colour = G.C.SUITS.Spades,
                    message_card = card,
                    message = "Nah, nah...",
                    colour = G.C.PURPLE,
                    message_card = card,
                    message = "Alright! I can see that I will have to teach you how to be villains!",
                    colour = G.C.SUITS.Spades,
                    message_card = card,
                    chips = 20,
                    chip_message = {message = "Hey!", colour = G.C.PURPLE, message_card = card },
                    mult = 10,
                    chip_message = {message = "We are Number One!", colour = G.C.PURPLE, message_card = card },
                    chips = 20,
                    chip_message = {message = "Hey!", colour = G.C.PURPLE, message_card = card },
                    mult = 10,
                    chip_message = {message = "We are Number One!", colour = G.C.PURPLE, message_card = card },
                    message = "Now, listen closely.",
                    colour = G.C.SUITS.Spades,
                    message_card = card,
                }
            end
            if context.individual and context.cardarea == G.play then
                card.ability.extra.position = card.ability.extra.position + 1
                if card.ability.extra.position <= 5 then
                    return {
                        message = card.ability.extra.lines[card.ability.extra.position],
                        colour = G.C.SUITS.Spades,
                        message_card = card,
                        xmult = 5
                    }
                end
                if card.ability.extra.position = 6 then
                    return {
                        message = card.ability.extra.lines[card.ability.extra.position],
                        colour = G.C.SUITS.Spades,
                    }
                end
                if card.ability.extra.position = 7 then
                    return {
                        chips = 5
                        chip_message = {message = card.ability.extra.lines[card.ability.extra.position], colour = G.C.PURPLE, },
                    }
                end
                if card.ability.extra.position = 8 then
                    return {
                        mult = -10,
                        chips = -10,
                        xmult = 0.9,
                        xchips = 0.9,
                        emult = 1.2,
                        echips = 1.2,
                        money = 5,
                        message = card.ability.extra.lines[card.ability.extra.position],
                        colour = G.C.SUITS.Spades,
                    }
                end
                if card.ability.extra.position > 8 and card.ability.extra.position < 12 then -- rest
                    return {
                        mult = 20,
                        message = card.ability.extra.lines[card.ability.extra.position],
                        colour = G.C.PURPLE,
                    }
                end
                if card.ability.extra.position == 14 then -- rest
                    local voucher_card = SMODS.create_card({ area = G.play, key = selected_voucher }) -- Ignore the previous code and just use a key for a prefined voucher
                    local prev_state = G.STATE
                    voucher_card:start_materialize()
                    voucher_card.cost = 0
                    G.play:emplace(voucher_card)
                    delay(0.8)
                    G.FUNCS.use_card({ config = { ref_table = voucher_card } })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.5,
                        func = function()
                        voucher_card:start_dissolve()
                        return true
                    end
                    }))
                    return {
                        message = card.ability.extra.lines[card.ability.extra.position],
                        colour = G.C.SUITS.Spades,
                    }
                end
                if card.ability.extra.position > 8 and card.ability.extra.position < 19 then -- rest
                    return {
                        message = card.ability.extra.lines[card.ability.extra.position],
                        colour = G.C.SUITS.Spades,
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

                if card.ability.extra.position >= 21 and card.ability.extra.position <= 40 then -- rest
                    return {
                        message = card.ability.extra.lines[card.ability.extra.position],
                    }
                end
                if card.ability.extra.position >= 41 then -- failsafe
                    card.ability.extra.position = 0
                    return {
                        xmult = 2
                        message = card.ability.extra.lines[41],
                    }
                end
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
