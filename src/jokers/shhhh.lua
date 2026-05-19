if Cryptid then
    SMODS.Joker {
        key = "secret",
        rarity = "cry_exotic",
        cost = 50,
        --no_collection = true,
        atlas = "jonklers",
        pos = { x = 0, y = 0 },
        soul_pos = { x = 1, y = 0, extra = { x = 2, y = 0 } },
        config = { extra = { xmult = 11, xmult_gain = 1, emult = 1.1, emult_gain = 0.02, backfire_mult = -10, backfire_chips = -10, position = 0, lines = { "Here's a little lesson in trickery.", "This is going down in history.", "If you wanna be a Villain Number One,", "You have to chase a superhero on the run!", "Just follow my moves, and sneak around.", "Be careful not to make a sound!", "(Shh!)", "(No, don't touch that!)", "We are Number One!", "Hey!", "We are Number One!", "We are Number One!", "Hahaha!", "Now look at this net, that I just found.", "When I say go, be ready to throw.", "Go!", "Throw it on him, not me!", "Ugh, let's try something else!", "Now watch and learn, here's the deal!", "He'll slip and slide on this banana peel!", "(Ha ha ha, gasp! What are you doing!?)", "Ba-ba-biddly-ba-ba-ba-ba,", "Ba-ba-ba-ba-ba-ba-ba!", "We are Number One!", "Hey!" --[[]], "Ba-ba-biddly-ba-ba-ba-ba,", "Ba-ba-ba-ba-ba-ba-ba!", "We are Number One!", "Ba-ba-biddly-ba-ba-ba-ba,", "Ba-ba-ba-ba-ba-ba-ba!", "We are Number One!", "Hey!", "Ba-ba-biddly-ba-ba-ba-ba,", "Ba-ba-ba-ba-ba-ba-ba!", "We are Number One!", "Hey!", "Hey!", --[[loop]] "Hey!", "We are Number One", "Hey!", "We are Number One" } } },
        loc_vars = function(self, info_queue, card)
            local piss = card.ability.extra.lines[2]
            return { vars = { card.ability.extra.xmult } }
        end,
        calculate = function(self, card, context)
            if context.before and card.ability.extra.position >= 1 and card.ability.extra.position <= 36 then -- to protect against value fuckery
                card.ability.extra.position = math.floor(card.ability.extra.position)
            end
            if context.before and card.ability.extra.position <= 0 then
                card.ability.extra.position = 0
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
                    chips = card.ability.extra.xmult,
                    chip_message = {message = "Hey!", colour = G.C.PURPLE, message_card = card },
                    mult = card.ability.extra.xmult,
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
            if context.before and card.ability.extra.position >= 37 then
                card.ability.extra.position = 0
                return {
                    message = "Alright! Let's go over it, once more!",
                    colour = G.C.SUITS.Spades,
                    message_card = card,
                    chips = card.ability.extra.xmult,
                    chip_message = {message = "Hey!", colour = G.C.PURPLE, message_card = card },
                    mult = card.ability.extra.xmult,
                    mult_message = {message = "We are Number One!", colour = G.C.PURPLE, message_card = card },
                    xchips = 20,
                    xchip_message = {message = "Hey!", colour = G.C.PURPLE, message_card = card },
                    xmult = 10,
                    xmult_message = {message = "We are Number One!", colour = G.C.PURPLE, message_card = card },
                    message = "Now, listen closely.",
                    colour = G.C.SUITS.Spades,
                    message_card = card,
                }
            end
            if context.main then
                if not context.blueprint then
                    card.ability.extra.position = card.ability.extra.position + 1
                end
                if card.ability.extra.position <= 5 then
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                    return {
                        message = card.ability.extra.lines[card.ability.extra.position],
                        colour = G.C.SUITS.Spades,
                        message_card = card,
                        xmult = card.ability.extra.xmult
                    }
                end
                if card.ability.extra.position = 6 then -- Be careful not to make a sound!
                    return {
                        message = card.ability.extra.lines[card.ability.extra.position],
                        colour = G.C.SUITS.Spades,
                    }
                end
                if card.ability.extra.position = 7 then -- Shh!
                    return {
                        chips = 744
                        chip_message = {message = card.ability.extra.lines[card.ability.extra.position], colour = G.C.PURPLE},
                    }
                end
                if card.ability.extra.position = 8 then -- No, don't touch that!
                    return {
                        mult = card.ability.extra.backfire_mult,
                        chips = card.ability.extra.backfire_chips,
                        money = 5,
                        message = card.ability.extra.lines[card.ability.extra.position],
                        colour = G.C.SUITS.Spades,
                    }
                end
                if card.ability.extra.position > 8 and card.ability.extra.position <= 12 then -- We are Number One!
                    card.ability.extra.emult = card.ability.extra.emult + card.ability.extra.emult_gain
                    return {
                        emult = card.ability.extra.emult,
                        message = card.ability.extra.lines[card.ability.extra.position],
                        colour = G.C.PURPLE,
                    }
                end
                if card.ability.extra.position == 13 then -- Hahaha!
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                    card.ability.extra.emult = card.ability.extra.emult + card.ability.extra.emult_gain
                    return {
                        xmult = card.ability.extra.xmult,
                        emult = card.ability.extra.emult,
                        message = card.ability.extra.lines[card.ability.extra.position],
                        colour = G.C.SUITS.Spades,
                    }
                end
                if card.ability.extra.position == 14 then -- Now look at this net that I just found
                    local voucher_card = SMODS.create_card({ area = G.play, key = 'v_cry_hyperspacetether' }) -- Ignore the previous code and just use a key for a prefined voucher
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
                if card.ability.extra.position >= 15 and card.ability.extra.position <= 18 then -- rest
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                    return {
                        xmult = card.ability.extra.xmult
                        message = card.ability.extra.lines[card.ability.extra.position],
                        colour = G.C.SUITS.Spades,
                    }
                end
                if card.ability.extra.position == 19 then -- trying something else :)
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                    return {
                        xchips = card.ability.extra.xmult - card.ability.extra.xmult_gain
                        message = card.ability.extra.lines[card.ability.extra.position],
                        colour = G.C.SUITS.Spades,
                    }
                end
                if card.ability.extra.position == 20 then -- He'll slip and slide on this banana peel!
                    if G.GAME.pool_flags.gros_michel_extinct == true then
                        SMODS.add_card { set = 'Joker', key = "j_cavendish", edition = 'e_negative' }
                    else
                        SMODS.add_card { set = 'Joker', key = "j_gros_michel", edition = 'e_negative' }
                    end
                    return {
                        message = card.ability.extra.lines[card.ability.extra.position],
                    }
                end
                if card.ability.extra.position == 21 then -- What are you doing!?
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
                if card.ability.extra.position == 22 or card.ability.extra.position == 23 or card.ability.extra.position == 26 or card.ability.extra.position == 27 or card.ability.extra.position == 29 or card.ability.extra.position == 30 or card.ability.extra.position == 33 or card.ability.extra.position == 34 then -- Ba-ba-biddly-ba-ba-ba-ba, ba-ba-ba-ba-ba-ba-ba
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                    return {
                        xmult = card.ability.extra.xmult,
                        message = card.ability.extra.lines[card.ability.extra.position],
                        colour = G.C.PURPLE,
                    }
                end
                if card.ability.extra.position == 24 or card.ability.extra.position == 28 or card.ability.extra.position == 31 or card.ability.extra.position == 35 or card.ability.extra.position == 39 then -- We are Number One!
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                    card.ability.extra.emult = card.ability.extra.emult + card.ability.extra.emult_gain
                    return {
                        xmult = card.ability.extra.xmult,
                        emult = card.ability.extra.emult,
                        message = card.ability.extra.lines[card.ability.extra.position],
                        colour = G.C.PURPLE,
                    }
                end
                if card.ability.extra.position == 25 or card.ability.extra.position == 32 or (card.ability.extra.position >= 36 and card.ability.extra.position < 39) or card.ability.extra.position == 40 then -- Hey!
                    card.ability.extra.emult = card.ability.extra.emult + card.ability.extra.emult_gain
                    return {
                        emult = card.ability.extra.emult,
                        message = card.ability.extra.lines[card.ability.extra.position],
                        colour = G.C.PURPLE,
                    }
                end
                if card.ability.extra.position >= 41 then -- failsafe
                    card.ability.extra.position = 0
                    return {
                        emult = 5
                        message = "why are you even spawning enemies here",
                    }
                end
            end
        end,
        in_pool = function(self, args) return false end
    }
end
