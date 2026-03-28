--#region Atlases

SMODS.Atlas = {
    key = 'battat',
    path = 'jonklers.png',
    px = 71,
    py = 95
}

--#endregion

--#region File Loading
local jokers_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/jokers")
for _, file in ipairs(jokers_src) do
    assert(SMODS.load_file("jokers/src" .. file))()
end

--#endregion