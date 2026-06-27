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
