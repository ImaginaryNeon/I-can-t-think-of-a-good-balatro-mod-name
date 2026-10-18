SMODS.JimboQuip({
    key = 'radio',
    extra = {
        center              = 'j_neonmod_portalradio',
        particle_colours    = {
            G.C.BLUE,
            G.C.WHITE,        --darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            G.C.UI.TEXT_DARK, --lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        },
        materialize_colours = {
            G.C.BLUE,
            G.C.WHITE,        --darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            G.C.UI.TEXT_DARK, --lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }
    },
    filter = function(self, type)
        local list = { "_1", "_2", "_3", "_4", "_5", "_6", "_7", "_8", "_9", "_11" }
        local random_element = pseudorandom_element(list,
            "neonmod_radio_quips" .. G.GAME.round_resets.ante)
        if next(SMODS.find_card('j_neonmod_portalradio')) then --or next(SMODS.find_card('j_neonmod_unboundradio')) then
            if type == 'win' then
                self.extra.text_key = self.key .. random_element .. '_win'
                return true, { weight = 20 }
            elseif type == 'loss' then
                self.extra.text_key = self.key .. random_element .. '_loss'
                return true, { weight = 20 }
            end
        end
    end
})

SMODS.JimboQuip({
    key = 'unbound_radio',
    extra = {
        center = 'j_neonmod_unboundradio',
        --[[particle_colours    = {
            G.C.BLUE,
            G.C.WHITE,        --darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            G.C.UI.TEXT_DARK, --lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        },
        materialize_colours = {
            G.C.BLUE,
            G.C.WHITE,        --darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            G.C.UI.TEXT_DARK, --lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }--]]
    },
    filter = function(self, type)
        if next(SMODS.find_card('j_neonmod_unboundradio')) then
            local winlist = { "_1", "_2", "_3", "_4", "_5", "_6" }
            local winitem = pseudorandom_element(winlist, "neonmod_radio_quips" .. G.GAME.round_resets.ante)
            if type == 'win' then
                self.extra.text_key = self.key .. winitem .. '_win'
                return true, { weight = 20 }
            elseif type == 'loss' then
                self.extra.text_key = self.key .. winitem .. '_loss'
                return true, { weight = 20 }
            end
        end
    end
})

SMODS.JimboQuip({
    key = 'stupendium',
    extra = {
        center = 'j_neonmod_stupendium',
        --[[particle_colours    = {
            G.C.BLUE,
            G.C.WHITE,        --darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            G.C.UI.TEXT_DARK, --lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        },
        materialize_colours = {
            G.C.BLUE,
            G.C.WHITE,        --darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            G.C.UI.TEXT_DARK, --lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }--]]
    },
    filter = function(self, type)
        local list = { "_1", "_2", "_3" }
        local random_element = pseudorandom_element(list,
            "neonmod_radio_quips" .. G.GAME.round_resets.ante)
        if next(SMODS.find_card('j_neonmod_stupendium')) then
            if type == 'win' then
                if next(SMODS.find_card('j_neonmod_fraudfirst')) or next(SMODS.find_card('j_neonmod_fraudsecond')) or next(SMODS.find_card('j_neonmod_fraudthird')) or
                    next(SMODS.find_card('j_neonmod_fraudclimax')) or next(SMODS.find_card('j_neonmod_fraudclimax_alt')) then
                    local listF = { "_fraud_1", "_fraud_2", "_fraud_3" }
                    local random_elementF = pseudorandom_element(listF,
                        "neonmod_radio_quips" .. G.GAME.round_resets.ante)
                    self.extra.text_key = self.key .. random_elementF .. '_win'
                    return true, { weight = 20 }
                else
                    self.extra.text_key = self.key .. random_element .. '_win'
                    return true, { weight = 20 }
                end
            elseif type == 'loss' then
                if next(SMODS.find_card('j_neonmod_cancerous')) or next(SMODS.find_card('j_neonmod_verycancerous')) then
                    if next(SMODS.find_card('j_neonmod_marksman')) or next(SMODS.find_card('j_neonmod_marksmanunbound')) then
                        self.extra.text_key = self.key .. '_rodent_gun_loss'
                        return true, { weight = 50 }
                    else
                        local list2 = { "_rodent_1", "_rodent_2", "_rodent_3" }
                        local random_element2 = pseudorandom_element(list2,
                            "neonmod_radio_quips" .. G.GAME.round_resets.ante)
                        self.extra.text_key = self.key .. random_element2 .. '_loss'
                        return true, { weight = 25 }
                    end
                elseif next(SMODS.find_card('j_neonmod_fraudfirst')) or next(SMODS.find_card('j_neonmod_fraudsecond')) or next(SMODS.find_card('j_neonmod_fraudthird')) or
                    next(SMODS.find_card('j_neonmod_fraudclimax')) or next(SMODS.find_card('j_neonmod_fraudclimax_alt')) then
                    local listF = { "_fraud_1", "_fraud_2", "_fraud_3" }
                    local random_elementF = pseudorandom_element(listF,
                        "neonmod_radio_quips" .. G.GAME.round_resets.ante)
                    self.extra.text_key = self.key .. random_elementF .. '_loss'
                    return true, { weight = 20 }
                else
                    self.extra.text_key = self.key .. random_element .. '_loss'
                    return true, { weight = 20 }
                end
            end
        end
    end
})
--[[
SMODS.JimboQuip({
    key = 'radio_2',
    extra = {
        center              = 'j_neonmod_portalradio',
        particle_colours    = {
            G.C.BLUE,
            G.C.WHITE,        --darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            G.C.UI.TEXT_DARK, --lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        },
        materialize_colours = {
            G.C.BLUE,
            G.C.WHITE,        --darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            G.C.UI.TEXT_DARK, --lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }
    },
    filter = function(self, type)
        if next(SMODS.find_card('j_neonmod_portalradio')) then --or next(SMODS.find_card('j_neonmod_unboundradio')) then
            if type == 'win' then
                self.extra.text_key = self.key .. '_win'
                return true, { weight = 10 }
            elseif type == 'loss' then
                self.extra.text_key = self.key .. '_loss'
                return true, { weight = 10 }
            end
        end
    end
})--]]
