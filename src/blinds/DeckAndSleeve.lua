SMODS.Back {
	key = 'moodydeck',
	atlas = 'deck',
	pos = { x = 0, y = 0 },
	--	unlocked = false,
	calculate = function(self, back, context)
		if context.setting_blind then
			local handlist1 = {}
			--print(table.concat(G.handlist, ", "))
			for hand, index in pairs(G.GAME.hands) do
				--print(localize(index.key, 'poker_hands'))
				if not (localize(index.key, 'poker_hands') == "ERROR") then
					table.insert(handlist1, index.key)
				end
			end
			local hand1 = pseudorandom_element(handlist1, 'Here\'s a little lesson in RNG.')
			for hand, index in pairs(G.GAME.hands) do
				--print(localize(index.key, 'poker_hands'))
				if not (localize(index.key, 'poker_hands') == "ERROR") and not (index.key == hand1) then
					table.insert(handlist1, index.key)
				end
			end
			local hand2 = pseudorandom_element(handlist1, 'This is going down in history.')
			return {
				level_up = -1,
				level_up_hand = hand1,
				extra = { level_up = 2, level_up_hand = hand2 }
			}
		end
	end,
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
			if self.get_current_deck_key() == "b_neonmod_moodydeck" then
				if context.modify_hand or context.pre_discard then
					local handlist1 = {}
					--print(table.concat(G.handlist, ", "))
					for hand, index in pairs(G.GAME.hands) do
						--print(localize(index.key, 'poker_hands'))
						if not (localize(index.key, 'poker_hands') == "ERROR") then
							table.insert(handlist1, index.key)
						end
					end
					local hand1 = pseudorandom_element(handlist1, 'Here\'s a little lesson in RNG.')
					for hand, index in pairs(G.GAME.hands) do
						--print(localize(index.key, 'poker_hands'))
						if not (localize(index.key, 'poker_hands') == "ERROR") and not (index.key == hand1) then
							table.insert(handlist1, index.key)
						end
					end
					local hand2 = pseudorandom_element(handlist1, 'This is going down in history.')
					return {
						level_up = -1,
						level_up_hand = hand1,
						extra = { level_up = 2, level_up_hand = hand2 }
					}
				end
			else
				if context.setting_blind then
					local handlist1 = {}
					--print(table.concat(G.handlist, ", "))
					for hand, index in pairs(G.GAME.hands) do
						--print(localize(index.key, 'poker_hands'))
						if not (localize(index.key, 'poker_hands') == "ERROR") then
							table.insert(handlist1, index.key)
						end
					end
					local hand1 = pseudorandom_element(handlist1, 'Here\'s a little lesson in RNG.')
					for hand, index in pairs(G.GAME.hands) do
						--print(localize(index.key, 'poker_hands'))
						if not (localize(index.key, 'poker_hands') == "ERROR") and not (index.key == hand1) then
							table.insert(handlist1, index.key)
						end
					end
					local hand2 = pseudorandom_element(handlist1, 'This is going down in history.')
					return {
						level_up = -1,
						level_up_hand = hand1,
						extra = { level_up = 2, level_up_hand = hand2 }
					}
				end
			end
		end
	}
end
