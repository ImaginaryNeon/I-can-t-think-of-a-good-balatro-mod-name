-- A bunch of functions modified from SealsOnJokers
--[[if SealsOnEverything then
function Neonmod.anything_and_everything_and(context, card, usage, dt)
    -- Get a list of each mod with Jokers
    local modspool = {}
    local pooltocollect = {}
    for k, v in pairs(G.P_CENTER_POOLS.Joker) do
        if (v.mod) then
            local found = false
            for k2, v2 in pairs(modspool) do
                if v2 == v.mod.id then 
                    found = true 
                end
            end
            if found == false then
                table.insert(modspool, v.mod.id)
            end
        end
    end
    -- Get a random joker from each mod
    for k, v in pairs(modspool) do
        local thismodlist = {}
        local thismodjkrcount = 0
        for k2, v2 in pairs(G.P_CENTER_POOLS.Joker) do
            if v2.mod == v then
                table.insert(thismodlist, v2.key)
                thismodjkrcount = thismodjkrcount + 1
            end
        end
        if thismodjkrcount > 0 then
            local randed_joker_for_this_mod = pseudorandom_element(thismodlist, "eventhorizonreachforthesunandburnburnburn".. G.GAME.round_resets.ante)
            table.insert(pooltocollect, randed_joker_for_this_mod)
        end
    end
--	local randed_joker = pseudorandom_element(pooltocollect, "modprefix_seed".. G.GAME.round_resets.ante)
    if usage == "calculate" then
        return Neonmod.get_some_jokers_returns_combined(context, card, pooltocollect)
	elseif usage == "add_to_deck" then
        for k, v in pairs(pooltocollect) do
            if v.key then v = v.key end
            local center = G.P_CENTERS[v]
            SEALS.run_joker_add_to_deck(v, false, card, not center.mod)
        end
    elseif usage == "remove_from_deck" then
        for k, v in pairs(pooltocollect) do
            if v.key then v = v.key end
            local center = G.P_CENTERS[v]
            SEALS.run_joker_remove_from_deck(v, false, card, not center.mod)
	end -- Not even going to try and understand what these are supposed to even hypothetically be doing within a mile of a Joker
    elseif usage == "update" then
        for k, v in pairs(pooltocollect) do
            if v.key then v = v.key end
            local center = G.P_CENTERS[v]
            SEALS.run_joker_update(v, dt, card, not center.mod)
        end
    end
end

function Neonmod.get_some_jokers_returns_combined(context, card, list)
    local effects_table = {}
    for k, v in pairs(list) do
        if type(v) == "table" and v.key then v = v.key end
        local center = G.P_CENTERS[v]
        local effect = SEALS.get_joker_return(v, context, card, not center.mod)
        if effect and type(effect) == 'table' and card.config.center_key == "j_soe_allinone" then
            effect.sealsfakekey = v
            effect.sealscard = card
            effect.func = function()
                card.ability.extra.currentjoker = G.P_CENTERS[v]
            end
        end
        if (effect and not effect.repetitions) or card.config.center_key ~= "j_soe_allinone" then
            effects_table[#effects_table+1] = effect
        end
        table.sort(effects_table, function(a, b)
            local a_sort = sort_returns(a)
            local b_sort = sort_returns(b)
            if a_sort == -1 and b_sort == -1 then return b_sort > a_sort end
            if a_sort == -1 then return true end
            if b_sort == -1 then return false end
            return a_sort < b_sort
        end)
    end
    return SMODS.merge_effects(effects_table)
end
]]
--[[
SMODS.Joker {
    key = 'welcometotheinternet',
    atlas = 'jonklers',
    pos = {
        x = 0,
        y = 3
    },
    rarity = 3,
    cost = 10,
    config = {extra = {currentjokers = {}}},
	update = function (self, card, dt)
        card:set_eternal(true)
        card.children.center.pinch.x = false
--        if card.children.floating_sprite.atlas ~= G.ASSET_ATLAS["soe_Enhancers"] then
--            card.children.floating_sprite.atlas = G.ASSET_ATLAS["soe_Enhancers"]
--            card.children.floating_sprite:set_sprite_pos({x = 5, y = 3})
--            card.children.center:set_sprite_pos({x = 9, y = 9})
--        end -- unfathomable!
        if card.ability.extra.currentjokers then
            for k, v in pairs(card.ability.extra.currentjokers) do
                if v.key then v = v.key end
                local center = G.P_CENTERS[v]
                SEALS.run_joker_update(v, dt, card, not center.mod)
            end
        end
    end,
    loc_vars = function (self, info_queue, card)
        for k, v in pairs(card.ability.extra.currentjokers) do
            local center = G.P_CENTERS[v]
            --info_queue[#info_queue+1] = {key = center.key, set = center.set, specific_vars = card.ability.savedvalues[v]}
            info_queue[#info_queue+1] = center
        end
    end,
    calculate = function(self, card, context)
        return SEALS.get_some_jokers_returns_combined(context, card, card.ability.extra.currentjokers)
    end,
	end
--]]
