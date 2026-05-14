-- A bunch of functions modified from SealsOnJokers
function Neonmod.anything_and_everything_and(context, card, usage, dt)
    -- Get the keys for each mod with Jokers
    local modspool = {}
    local pooltocollect = {}
    for k, v in pairs(G.P_CENTER_POOLS.Joker) do
        -- or (v.mod.id == "paperback") or (v.mod.id == "jen" and v.key ~= "j_jen_gourmand" and v.rarity == "cry_exotic")
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
        -- or (v.mod.id == "paperback") or (v.mod.id == "jen" and v.key ~= "j_jen_gourmand" and v.rarity == "cry_exotic")
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
--[[    elseif usage == "add_to_deck" then
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
        end--]] -- Not even going to try and understand what these are supposed to even hypothetically be doing within a mile of a Joker
    elseif usage == "update" then
        for k, v in pairs(pooltocollect) do
            if v.key then v = v.key end
            local center = G.P_CENTERS[v]
            SEALS.run_joker_update(v, dt, card, not center.mod)
        end
    end
end

function Neonmod.get_joker_return(key, context, card, isvanilla, juicecard)
    local center = G.P_CENTERS[key]
    if center then
        card.ability.savedvalues = card.ability.savedvalues or {}
        card.ability.savedvalues[key] = card.ability.savedvalues[key] or copy_table(center.config)
        local fake_card = SEALS.create_fake_card(card, key, "calculate", juicecard)
        if card.config.center_key == "j_soe_allinone" then
            card.ability.extra.currentjoker = center
        end
        if center.calculate and type(center.calculate) == "function" and not isvanilla then
            return center:calculate(fake_card, context), fake_card
        end
        --if isvanilla then
            -- return SEALS.get_vanilla_joker_return(key, context, fake_card), fake_card -- too much code attatched to that :(
        --end
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
--[[
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
--]]
--local mod_whitelist = {
--        Ascensio = true,
--        Neato_Jokers = true,
--        GSBFDI = true,
--        TOGAPack = true,
--        ortalab = true,
--        paperback = true,
--        extracredit = true,
        --MoreFluff = true,
--        familiar = true,
--    }

SMODS.Joker {
    key = 'welcometotheinternet',
    atlas = 'jonklers',
    pos = {
        x = 0,
        y = 4
    },
    rarity = 2,
    cost = 6,
-- G.P_CENTER_POOLS.Joker
	config = {extra = {copied_joker = nil}},
    artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
        if card.ability.extra.copied_joker then
            if G.P_CENTERS[card.ability.extra.copied_joker.config.center_key] then
                info_queue[#info_queue+1] = G.P_CENTERS[card.ability.extra.copied_joker.config.center_key]
            end
            return {vars = {localize{type = 'name_text', set = "Joker", key = card.ability.extra.copied_joker.config.center_key, nodes = {}}}}
        else
            return {vars = {"None"}}
        end
    end,
    calculate = function(self, card, context) --Chameleon Joker Logic
        if context.setting_blind and not card.getting_sliced then
            card.ability.extra.copied_joker = nil
            local potential_jokers = {}
            for k, v in pairs(G.P_CENTERS) do
		        if v.set == "Joker" then
        	        if G.jokers.cards[i] ~= card and v.config.center.key ~= 'chameleon_joker' and v.config.center.key ~= 'welcometotheinternet' and v.config.center.blueprint_compat then
                    potential_jokers[#potential_jokers+1] = G.jokers.cards[i]
                end
            end
            if #potential_jokers > 0 then
                local chosen_joker = pseudorandom_element(potential_jokers, pseudoseed('welcome to the internet'))
                for i, joker in ipairs(G.jokers.cards) do
                    if joker == chosen_joker then 
                        card.ability.extra.copied_joker_pos = i
                    end
                end
                card.ability.extra.copied_joker = chosen_joker
            end	
        end
        if card.ability.extra.copied_joker then
            context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
            context.blueprint_card = context.blueprint_card or card
            if context.blueprint > #G.jokers.cards + 1 then return end
            local other_joker_ret = card.ability.extra.copied_joker:calculate_joker(context)
            context.blueprint = nil
            local eff_card = context.blueprint_card or self
            context.blueprint_card = nil
            if other_joker_ret then
                other_joker_ret.card = card
                other_joker_ret.colour = G.C.GREEN
                return other_joker_ret
            end
        end
    end,
    load = function(self, card, card_table, other_card)
        card.loaded = true
    end,
    update = function(self, card, dt)
        if card.loaded then
            card.ability.extra.copied_joker = G.jokers.cards[card.ability.extra.copied_joker_pos]
            if card.ability.extra.copied_joker then
                card.loaded = false
            end
        end
    end
}
