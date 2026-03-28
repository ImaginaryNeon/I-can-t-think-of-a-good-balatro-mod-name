--#region Atlases

SMODS.Atlas = { -- Jokers
    key = 'battat',
    path = 'jonklers.png',
    px = 71,
    py = 95
}

SMODS.Atlas = { -- Blinds
    key = 'bossbattle',
    path = 'blinding.png',
    px = 32,
    py = 32
}

--#endregion

--#region File Loading

local jokers_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/jokers")
for _, file in ipairs(jokers_src) do
    assert(SMODS.load_file("src/jokers/" .. file))()
end

--#endregion