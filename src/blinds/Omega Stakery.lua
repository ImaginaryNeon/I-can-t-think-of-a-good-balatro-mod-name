local isCryptid = SMODS.find_mod("Cryptid")[1]
local abovestake = (isCryptid and "cry_ascendant") or "gold"

SMODS.Stake {
    name = "Omega Stakery",
    key = "omega",
    pos = { y = 0 },
    atlas = "stakery",
    applied_stakes = { abovestake },
    above_stake = abovestake,
    colour = HEX("aedaf0"),
    sticker_atlas = "stickerpot",
    sticker_pos = { y = 0 },
    --[[loc_vars = function(self, info_queue, card)
        return { vars = { colours = { HEX('43c77b') } }, }
    end,--]]
    prefix_config = { applied_stakes = { mod = false }, above_stake = { mod = false } },
    modifiers = function()
        local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_flower_pot")
		--card:set_edition("e_negative", true, nil, true)
		card.ability.pinned = true
        card.ability.eternal = true
		card:add_to_deck()
		G.jokers:emplace(card)
    end,
}