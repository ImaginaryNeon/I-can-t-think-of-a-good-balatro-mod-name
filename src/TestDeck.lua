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
    end
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
