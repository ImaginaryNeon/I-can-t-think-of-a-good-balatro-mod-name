local isCryptid = SMODS.find_mod("Cryptid")[1]
local abovestake = (isCryptid and "cry_ascendant") or "gold"
--[[
SMODS.Stake {
    name = "Omega Stakery",
    key = "omega",
    pos = { x = 1, y = 0 },
    atlas = "stakerystatic",
    applied_stakes = { abovestake },
    above_stake = abovestake,
    colour = HEX("aedaf0"),
    sticker_atlas = "stickerpot",
    sticker_pos = { y = 0 },
    prefix_config = { applied_stakes = { mod = false }, above_stake = { mod = false } },
    modifiers = function()
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.add_card{ key = "j_flower_pot", force_stickers = {'eternal', 'pinned'} }
                return true
            end
        }))
    end,
}--]]