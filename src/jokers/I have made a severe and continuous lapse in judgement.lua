SMODS.current_mod.calculate = function(self, context)
    G.GAME.neonmod_recentvolumes = G.GAME.neonmod_recentvolumes or {}
    G.GAME.neonmod_inputdevices = #love.audio.getRecordingDevices()
    G.GAME.neonmod_outputdevices = {} --love.audio.getPlaybackDevices()33
    G.GAME.neonmod_devicecount = G.GAME.neonmod_inputdevices
    -- G.GAME.neonmod_devicecount = (tonumber(#G.GAME.neonmod_inputdevices) or 0) + (tonumber(#G.GAME.neonmod_outputdevices) or 0)
    -- G.GAME.neonmod_maindevice = G.GAME.neonmod_maindevice or nil
    --[[if #G.GAME.neonmod_inputdevices > 0 then
        G.GAME.neonmod_maindevice = G.GAME.neonmod_inputdevices[1]
    end
    table.insert(G.GAME.neonmod_recentvolumes, "???")
    if #G.GAME.neonmod_recentvolumes >= 20 then
        table.remove(G.GAME.neonmod_recentvolumes, 1)
    end]]
end -- doesn't do much rn because there's seemingly no way to get the actual volume

SMODS.Attribute {
    key = 'overrule_compat',
    keys = { 'j_jolly' }
}
SMODS.Attribute { key = 'nintendo' }
SMODS.Attribute { key = 'videogame' }
SMODS.Attribute { key = 'unbound' }

Neonmod = Neonmod or {}
Neonmod.mod = SMODS.current_mod

function Neonmod.get_highlighted_cards(areas, ignore, min, max, blacklist, seed)
    ignore.checked = true
    blacklist = blacklist or function()
        return true
    end
    local cards = {}
    for i, area in pairs(areas) do
        if area.cards then
            for i2, card in pairs(area.cards) do
                if
                    card ~= ignore
                    and blacklist(card)
                    and (card.highlighted)
                    and not card.checked
                then
                    cards[#cards + 1] = card
                    card.checked = true
                end
            end
        end
    end
    for i, v in ipairs(cards) do
        v.checked = nil
    end
    if (#cards >= min and #cards <= max) then
        ignore.checked = nil
        return cards
    else
        for i, v in pairs(cards) do
            v.f_use_order = i
        end
        pseudoshuffle(cards, pseudoseed("forcehighlight" or seed))
        local actual = {}
        for i = 1, max do
            if cards[i] and not cards[i].checked and actual ~= ignore then
                actual[#actual + 1] = cards[i]
            end
        end
        table.sort(actual, function(a, b)
            return a.f_use_order < b.f_use_order
        end)
        for i, v in pairs(cards) do
            v.f_use_order = nil
        end
        ignore.checked = nil
        return actual
    end
    return {}
end
