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
    rarity = 1,
    cost = 5,
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
if Cryptid then
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
    rarity = 1,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.increase
            }
        }
    end,
	calculate = function(self, card, context)
		if (context.end_of_round and not context.repetition and not context.individual and not context.blueprint) or context.forcetrigger
		then
			local check = false
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if i < #G.jokers.cards then
						if not Card.no(G.jokers.cards[i + 1], "immutable", true) and not G.jokers.cards[i + 1].config.center.key == j_neonmod_stupendium then
							check = true
							Cryptid.manipulate(G.jokers.cards[i + 1], { value = card.ability.extra.increase, type = "+" })
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
end

