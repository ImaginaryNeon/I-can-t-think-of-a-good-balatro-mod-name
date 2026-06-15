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
    path = 'Deck.png',
    px = 71,
    py = 95
}

SMODS.Atlas { -- Sleeve
    key = "sleeveatlas",
    path = "Sleeve.png",
    px = 73,
    py = 95
}

SMODS.Atlas { -- Mannpower Blinds
    key = 'personalized',
    path = 'personalized.png',
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
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

if JokerDisplay then
    SMODS.load_file("joker_display_definitions.lua")()
end

--local random_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/random")
--for _, file in ipairs(random_src) do
--    assert(SMODS.load_file("src/random/" .. file))()
--end

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
Neonmod = SMODS.current_mod

Neonmod.joker_value_exclusions = {
    x_mult = 1,
    x_chips = 1,
    xmult = 1,
    xchips = 1,
    h_size = 0,
    d_size = 0,
    mult = 0,
    chips = 0,
    e_mult = 1,
    e_chips = 1,
    emult = 1,
    echips = 1,
}

-- Thanks to [Name here once I check Discord] for pointing me towards this.
function Neonmod.perform_operations(val1, op, val2)
    if type(val2) == 'number' then
        if op == '=' then return val2 end
        if op == '+' then return val1 + val2 end
        if op == '-' then return val1 - val2 end
        if op == '*' then return val1 * val2 end
        if op == '/' then return val1 / val2 end
        if op == '%' then return val1 % val2 end
        --        if op == '^' then return val1 ^ val2 end
    elseif type(val1) == 'number' and type(val2) == 'table' then
        local final = val1
        for _, v in ipairs(val2) do
            final = Neonmod.perform_operations(final, op, v)
        end
        return final
    end
end

SMODS.Atlas { -- shh
    key = "secret",
    path = "boring_stuff.png",
    px = 71,
    py = 95
}

function Neonmod.modify_joker_values(card, modifytbl, exclusions, ignoreimmutable, nodeckeffects)
    if not card or not modifytbl or (card.config.center.immutable and not ignoreimmutable) then return end
    -- local cardwasindeck = card.added_to_deck
    -- if not nodeckeffects and cardwasindeck then card:remove_from_deck(true) end
    exclusions = exclusions or Neonmod.joker_value_exclusions
    local ops = { '=', '+', '-', '*', '/', '%' } --, '^'}
    local function modify_value(ref_table, ref_value, isdirectlyinability)
        local value = ref_table[ref_value]
        if type(value) == 'table' and (ignoreimmutable or ref_value ~= 'immutable') and (not isdirectlyinability or exclusions[ref_value] ~= true) then
            for k in pairs(value) do
                modify_value(value, k)
            end
        elseif type(value) == 'number' and (not isdirectlyinability or (not (exclusions[ref_value] == true or exclusions[ref_value] == value))) then
            for _, v in ipairs(ops) do
                if modifytbl[v] then
                    ref_table[ref_value] = Neonmod.perform_operations(value, v, modifytbl[v])
                end
            end
        end
    end
    card:generate_UIBox_ability_table(true)
    for k in pairs(card.ability) do
        modify_value(card.ability, k, true)
    end
    --[[    local probmod = card.ability.soe_probability_modifier or {}
    for _, v in ipairs(ops) do
        if modifytbl[v] then
            probmod[v] = probmod[v] or {}
            probmod[v][#probmod[v]+1] = {value = modifytbl[v], denominator = true, numerator = true}
        end
    end
    card.ability.soe_probability_modifier = probmod--]] -- no clue what this does
    -- if not nodeckeffects and cardwasindeck then card:add_to_deck(true) end
end
