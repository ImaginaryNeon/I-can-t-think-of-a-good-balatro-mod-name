SMODS.Back {
    key = 'moodydeck',
    atlas = 'deck',
    pos = { x = 0, y = 0 },
    --	unlocked = false,
    calculate = function(self, back, context)
        if context.setting_blind then -- and G.GAME.blind.boss
            local raising_hand = pseudorandom_element(G.handlist, "Here's a little lesson in RNG.")
            local falling_hand = pseudorandom_element(G.handlist, "This is going down, exposit'ry.")
            --[[ -- wip code for avoiding the same being chosen for both.
		    if falling_hand == raising_hand then
          		local falling_hand = pseudorandom_element(G.handlist, 'If you wanna be a Modder Number One,')
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
        atlas = "sleeveatlas",
        pos = { x = 0, y = 0 },
		unlocked = false,
        unlock_condition = { deck = "b_neonmod_moodydeck", stake = "stake_blue" },
        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_neonmod_moodydeck" then
                key = self.key .. "_alt"
                return { key = key, vars = {} }
            end
            return { key = key, vars = vars }
        end,
        calculate = function(self, sleeve, context)
            if self.get_current_deck_key() = "b_neonmod_moodydeck" then
                if context.before or context.pre_discard then
        		    local raising_hand = pseudorandom_element(G.handlist, "You have to chase a pseudorandom on the run!")
       			    local falling_hand = pseudorandom_element(G.handlist, 'Just follow my moves, and sneak around...')
            --[[ -- wip code for avoiding the same being shown for both.
					if falling_hand == raising_hand then
          				falling_hand = pseudorandom_element(G.handlist, "Be careful not to make a sound. (Shh...)")
						raising_hand = nil
						raising_hand = pseudorandom_element(G.handlist, "No, don't touch that!")
      				end
					--]]
	            	if not falling_hand == nil then
    	            	return {
        	            	level_up = -1, -- We are Number One! (Hey!)
            	        	level_up_hand = falling_hand
                		}
      	    		end
        	    	if not raising_hand == nil then
                	return {
                    	level_up = 2, -- We are Number One!
                    	level_up_hand = raising_hand -- We are Number One!
                	}
            		end
				end
			else
				if context.setting_blind then -- and G.GAME.blind.boss
        		    local raising_hand = pseudorandom_element(G.handlist, "Now look at this net, that I just found")
       			    local falling_hand = pseudorandom_element(G.handlist, "When I say go, be ready to throw. (Go!)")
            --[[ -- wip code for avoiding the same being shown for both.
      			if falling_hand == raising_hand then
      			    local falling_hand = pseudorandom_element(G.handlist, 'Throw it on him, not me!')
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
		        end
			end
    	end
	}
end
