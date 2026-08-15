SMODS.Blind {
    key = 'fleshprison',
    atlas = 'bossbattle',
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            xmult = 0.9,
        },
    },
    boss = { min = 2 },
    boss_colour = HEX('701814'),
    loc_vars = function(self)
        return { vars = { self.config.extra.xmult } }
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.post_trigger then
                return {
                    xmult = blind.effect.extra.xmult,
                    message = 'Decayed!',
                    card = context.blueprint_card or context.other_card or blind,
                }
            end
            if context.cardarea == G.play and context.main_scoring then
                return {
                    xmult = blind.effect.extra.xmult,
                    message = 'Decayed!',
                }
            end
        end
    end
}

--[[local letter = string.sub(G.PROFILES[G.SETTINGS.profile].name, 1, 1)
local yvalue = letter
for i = 1, 10, 2 do
  print(i)
end]]

SMODS.Blind {
    key = 'personalizedblind',
    atlas = 'personalized',
    pos = {
        y = 1
    },
    config = { extra = { hands = {} } },
    dollars = 5,
    mult = 2,
    boss = { min = 3 },
    boss_colour = HEX("b9cb92"),
    calculate = function(self, blind, context)
        if blind.disabled then return end
        --[[        if context.setting_blind then
            blind.effect.extra.hands = {}
            for _, poker_hand in ipairs(G.handlist) do
                blind.effect.extra.hands[poker_hand] = false
            end
            local currenthands = {}
            local currentcount = 0
            for i, poker_hand in ipairs(G.handlist) do
                if G.PROFILES[G.SETTINGS.profile].hand_usage[poker_hand] then
                    if (G.PROFILES[G.SETTINGS.profile].hand_usage[poker_hand].count > currentcount) then
                        currenthands = { poker_hand }
                        currentcount = G.PROFILES[G.SETTINGS.profile].hand_usage[poker_hand].count
                    elseif G.PROFILES[G.SETTINGS.profile].hand_usage[poker_hand].count == currentcount then
                        table.insert(currenthands, G.PROFILES[G.SETTINGS.profile].hand_usage[poker_hand].count)
                    end
                end
            end
            for i, v in pairs(currenthands) do
                blind.effect.extra.hands[v] = true
            end
        end ]] -- old code
        if context.debuff_hand then
            if context.scoring_name == G.GAME.current_round.neonmod_bighandthing then
                blind.triggered = true
                return {
                    debuff = true
                }
            end
        end
    end,
}

SMODS.Blind {
    key = 'metablind',
    atlas = 'personalized',
    pos = {
        y = 0
    },
    dollars = 5,
    mult = 2,
    boss = { min = 4, max = 12 },
    config = { extra = { jokerbans = {} } },
    boss_colour = G.C.DARK_EDITION, -- HEX("263b64"),
    calculate = function(self, blind, context)
        if blind.disabled then return end
        --[[        if context.setting_blind then
            local currentbans = {}
            local microban = nil
            local currentcount = 0
            G.GAME.neonmod_jokerbans = {}
            for i = 1, 15 do
                currentcount = 0
                for _, v in pairs(G.P_CENTER_POOLS.Joker) do
                    v.neonmod_jokerbans = false
                    if G.PROFILES[G.SETTINGS.profile].joker_usage[v] then
                        local found = false
                        for _, v2 in pairs(currentbans) do
                            if v2 == v.key then
                                found = true
                            end
                        end
                        if found == false then
                            if (G.PROFILES[G.SETTINGS.profile].joker_usage[v].count > currentcount) then
                                microban = v.key
                                currentcount = G.PROFILES[G.SETTINGS.profile].joker_usage[v].count
                            end
                        end
                    end
                end
                table.insert(currentbans, microban)
            end
            for _, v in pairs(currentbans) do
                v.neonmod_jokerbans = true
            end
        end]]
        if context.debuff_card and context.debuff_card.area == G.jokers then
            if (G.PROFILES[G.SETTINGS.profile].joker_usage[context.debuff_card.config.center.key].count or 0) >= (G.GAME.current_round.neonmod_min_uses or 1) then
                return {
                    debuff = true
                }
            end
        end
    end,
}
--[[SMODS.Blind {
    key = 'earthmover',
    atlas = 'animblinds',
    pos = {
        y = 0
    },
    dollars = 5,
    mult = 2,
    boss = { min = 7 },
    boss_colour = HEX("2e73bf"),
    calculate = function(self, blind, context)
        if blind.disabled then return end
        if context.modify_hand then
            blind.triggered = true -- This won't trigger Matador in this context due to a Vanilla bug (a workaround is setting it in context.debuff_hand)
            local flush_chips = G.GAME.hands["Flush"].chips
            local flush_mult = G.GAME.hands["Flush"].mult
            mult = mod_mult(math.max(math.floor(mult - flush_mult), 0))
            hand_chips = mod_chips(math.max(math.floor(hand_chips - flush_chips), 0))
            update_hand_text({ sound = 'chips2', modded = true }, { chips = hand_chips, mult = mult })
        end
    end
}]]
