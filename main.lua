--#region Atlases

SMODS.Atlas { -- Jokers
    key = 'jonklers',
    path = 'jonklers.png',
    px = 71,
    py = 95
}

SMODS.Atlas { -- Blinds
    key = 'bossbattle',
    path = 'blinding.png',
    px = 34,
    py = 34
}

SMODS.Atlas { -- Deck
    key = 'deck',
    path = 'deck.png',
    px = 71,
    py = 95
}

SMODS.Atlas { -- Sleeve
    key = "sleeveatlas",
    path = "Sleeve.png",
    px = 73,
    py = 95
}

--#endregion

--#region File Loading

local jokers_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/jokers")
for _, file in ipairs(jokers_src) do
    assert(SMODS.load_file("src/jokers/" .. file))()
end

local blind_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/blinds")
for _, file in ipairs(blind_src) do
    assert(SMODS.load_file("src/blinds/" .. file))()
end

SMODS.current_mod.optional_features = function()
    return {
        post_trigger = true,
        retrigger_joker = true,
        cardareas = {
            discard = true,
            deck = true
        },
        object_weights = true
    }
end
--#endregion
