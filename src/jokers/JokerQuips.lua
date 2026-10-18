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
        local random_element, index_in_the_list = pseudorandom_element(list,
            "neonmod_radio_quips" .. G.GAME.round_resets.ante)
        if next(SMODS.find_card('j_neonmod_portalradio')) then --or next(SMODS.find_card('j_neonmod_unboundradio')) then
            if type == 'win' then
                self.extra.text_key = self.key .. random_element .. '_win'
                return true, { weight = 10 }
            elseif type == 'loss' then
                self.extra.text_key = self.key .. random_element .. '_loss'
                return true, { weight = 10 }
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
                return true, { weight = 10 }
            elseif type == 'loss' then
                self.extra.text_key = self.key .. winitem .. '_loss'
                return true, { weight = 10 }
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
