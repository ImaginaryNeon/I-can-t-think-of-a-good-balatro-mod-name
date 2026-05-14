SMODS.Back {
	key = 'moodydeck',
	atlas = 'deck',
	pos = { x = 0, y = 0 },
	--	unlocked = false,
	calculate = function(self, back, context)
		if context.setting_blind then
			return {
				level_up = -1,
				level_up_hand = pseudorandom_element(G.handlist, 'Here\'s a little lesson in RNG.'),
				extra = { level_up = 2, level_up_hand = pseudorandom_element(G.handlist, 'This is going down in history.') }
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
				if context.before or context.pre_discard then
					return {
						level_up = -1,
						level_up_hand = pseudorandom_element(G.handlist, 'Here\'s a little lesson in RNG.'),
						extra = { level_up = 2, level_up_hand = pseudorandom_element(G.handlist, 'This is going down in history.') }
					}
				end
			else
				if context.setting_blind then
					return {
						level_up = -1,
						level_up_hand = pseudorandom_element(G.handlist, 'Here\'s a little lesson in RNG.'),
						extra = { level_up = 2, level_up_hand = pseudorandom_element(G.handlist, 'This is going down in history.') }
					}
				end
			end
		end
	}
end
