--[[if Cryptid then -- 99.9% of this was shamelessly stolen from Cryptid
	SMODS.Joker {
		key = 'stupendium',
		atlas = 'jonklers',
		pos = {
			x = 2,
			y = 3
		},
		config = {
			extra = {
				increase = 1,
			}
		},
		rarity = 3,
		cost = 8,
		loc_vars = function(self, info_queue, card)
			card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ""
			card.ability.blueprint_compat_check = nil
			return {
				vars = { number_format(card.ability.extra.increase) },
				main_end = (card.area and card.area == G.jokers) and {
					{
						n = G.UIT.C,
						config = { align = "bm", minh = 0.4 },
						nodes = {
							{
								n = G.UIT.C,
								config = {
									ref_table = card,
									align = "m",
									colour = G.C.JOKER_GREY,
									r = 0.05,
									padding = 0.06,
									func = "blueprint_compat",
								},
								nodes = {
									{
										n = G.UIT.T,
										config = {
											ref_table = card.ability,
											ref_value = "blueprint_compat_ui",
											colour = G.C.UI.TEXT_LIGHT,
											scale = 0.32 * 0.8,
										},
									},
								},
							},
						},
					},
				} or nil,
			}
		end,
		update = function(self, card, front)
			if G.STAGE == G.STAGES.RUN then
				for i = 1, #G.jokers.cards do
					if G.jokers.cards[i] == card then
						other_joker = G.jokers.cards[i + 1]
					end
				end
				if other_joker and other_joker ~= card and not (Card.no(other_joker, "immutable", true)) then
					card.ability.blueprint_compat = "compatible"
				else
					card.ability.blueprint_compat = "incompatible"
				end
			end
		end,
		calculate = function(self, card, context)
			if (context.end_of_round and not context.repetition and not context.individual and not context.blueprint) or context.forcetrigger
			then
				local check = false
				for i = 1, #G.jokers.cards do
					if G.jokers.cards[i] == card then
						if i < #G.jokers.cards then
							if not G.jokers.cards[i + 1].config.center.key == "j_neonmod_stupendium" then -- and not card.no(G.jokers.cards[i + 1], "immutable", true)
								check = true
								Neonmod.modify_joker_values(G.jokers.cards[i + 1], { ['+'] = 1 })
							end
						end
					end
				end
				if check then
					card_eval_status_text(
						card,
						"extra",
						nil,
						nil,
						nil,
						{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
					)
				end
			end
		end,
	}
end--]]
