SMODS.Back {
    key = 'moodydeck',
    atlas = 'deck',
    pos = { x = 0, y = 0 },
    --	unlocked = false,
    calculate = function(self, card, context)
        if context.pre_discard and G.GAME.current_round.discards_used <= 0 and not context.hook then
            local text, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            if G.GAME.hands[text].level > 1 then
                return {
                    level_up = -1,
                    level_up_hand = text
                }
            end
        end
    end,
    -- if G.GAME.hands[chosen_hand].visible
    calculate = function(self, back, context)
        if context.round_eval and G.GAME.last_blind and G.GAME.last_blind.boss then
            local raising_hand = pseudorandom_element(G.handlist, 'neonmod_moodydeck')
            local falling_hand = pseudorandom_element(G.handlist, 'neonmod_moodydeck')
            --[[ -- wip code for avoiding the same being shown for both.
      if falling_hand == raising_hand then
          local falling_hand = pseudorandom_element(G.handlist, 'neonmod_moodydeck_2')
      end  --]]
            if not falling_hand == nil then
                return {
                    level_up = -1,
                    level_up_hand = falling_hand
                }
            end
            if not raising_hand == nil then
                return {
                    level_up = 2,
                    level_up_hand = raising_hand
                }
            end
            --[[	  update_hand_text({ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 }, {
    			handname = localize(raising_hand, "poker_hands"),
		    	chips = G.GAME.hands[raising_hand].chips,
    			mult = G.GAME.hands[raising_hand].mult,
	    		level = G.GAME.hands[raising_hand].level,
		})
--]]
        end
    end,
    --[[	check_for_unlock = function(self, args)
		if args.type == "strange_threshold2" then
			return true
		end
	end --]]
}
if CardSleeves then
    CardSleeves.Sleeve {
        key = "moodysleve",
        name = "Moody Sleve",
        atlas = "deck",
        pos = { x = 1, y = 0 },
        unlocked = false,
        unlock_condition = { deck = "b_mannpower_manndeck", stake = "stake_blue" },
        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_mannpower_manndeck" then
                key = self.key .. "_alt"
                self.config = { vouchers = { 'v_mannpower_tour_of_duty', 'v_mannpower_squad_surplus' } }
                return { key = key, vars = {} }
            end
            return { key = key, vars = vars }
        end,
        apply = function(self, sleeve)
            if self.get_current_deck_key() == "b_mannpower_manndeck" then
                for k, v in pairs(self.config.vouchers) do
                    G.GAME.used_vouchers[v] = true
                    G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            Card.apply_to_run(nil, G.P_CENTERS[v])
                            return true
                        end
                    }))
                end
            end
        end,
        calculate = function(self, sleeve, context)
            if self.get_current_deck_key() ~= "b_mannpower_manndeck" then
                if context.round_eval and G.GAME.last_blind and G.GAME.last_blind.boss then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local booster = SMODS.create_card { key = 'p_mannpower_powerpack_' .. math.random(1, 2), area = G.play }
                            booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                            booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                            booster.T.w = G.CARD_W * 1.27
                            booster.T.h = G.CARD_H * 1.27
                            booster.cost = 0
                            booster.from_tag = true
                            G.FUNCS.use_card({ config = { ref_table = booster } })
                            booster:start_materialize()
                            return true
                        end
                    }))
                end
            end
        end
    }
end
