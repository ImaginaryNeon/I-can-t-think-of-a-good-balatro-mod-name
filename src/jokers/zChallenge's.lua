SMODS.Challenge {
    key = "partikeo",
    rules = {
        custom = {
            { id = 'no_shop_jokers', value = true },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'j_riff_raff' },
            { id = 'v_antimatter' },
        },
        --banned_other = {
        --{ id = 'bl_hook', type = 'blind' },
        --},
    },
    jokers = {
        { id = 'j_neonmod_jester_mii', eternal = true },
        { id = 'j_perkeo',             eternal = true }
    },
    consumeables = {
        { id = 'c_lovers' }, --, eternal = true },
    },
    deck = {
        type = "Challenge Deck",
        -- seal = 'Blue',
    },
}
