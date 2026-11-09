SMODS.Challenge {
    key = "rewound",
    restrictions = {
        banned_cards = {
            { id = 'j_burglar' },
            { id = 'j_neonmod_redtape' },
        },
        banned_other = {
            --{ id = 'bl_hook', type = 'blind' },
            { id = 'bl_water', type = 'blind' },
        },
    },
    jokers = {
        { id = 'j_neonmod_redtapeunbound', eternal = true }
    },
    deck = {
        type = "Challenge Deck",
        -- seal = 'Blue',
        cards = {
            { s = 'C', r = 'A', g = 'Blue' },
            { s = 'D', r = 'A', g = 'Blue' },
            { s = 'H', r = 'A', g = 'Blue' },
            { s = 'S', r = 'A', g = 'Blue' },
            { s = 'C', r = 'K', g = 'Blue' },
            { s = 'D', r = 'K', g = 'Blue' },
            { s = 'H', r = 'K', g = 'Blue' },
            { s = 'S', r = 'K', g = 'Blue' },
            { s = 'C', r = 'Q', g = 'Blue' },
            { s = 'D', r = 'Q', g = 'Blue' },
            { s = 'H', r = 'Q', g = 'Blue' },
            { s = 'S', r = 'Q', g = 'Blue' },
            { s = 'C', r = 'J', g = 'Blue' },
            { s = 'D', r = 'J', g = 'Blue' },
            { s = 'H', r = 'J', g = 'Blue' },
            { s = 'S', r = 'J', g = 'Blue' },
            { s = 'C', r = 'T' },
            { s = 'D', r = 'T' },
            { s = 'H', r = 'T' },
            { s = 'S', r = 'T' },
            { s = 'C', r = '9' },
            { s = 'D', r = '9' },
            { s = 'H', r = '9' },
            { s = 'S', r = '9' },
            { s = 'C', r = '8' },
            { s = 'D', r = '8' },
            { s = 'H', r = '8' },
            { s = 'S', r = '8' },
            { s = 'C', r = '7' },
            { s = 'D', r = '7' },
            { s = 'H', r = '7' },
            { s = 'S', r = '7' },
            { s = 'C', r = '6' },
            { s = 'D', r = '6' },
            { s = 'H', r = '6' },
            { s = 'S', r = '6' },
            { s = 'C', r = '5' },
            { s = 'D', r = '5' },
            { s = 'H', r = '5' },
            { s = 'S', r = '5' },
            { s = 'C', r = '4' },
            { s = 'D', r = '4' },
            { s = 'H', r = '4' },
            { s = 'S', r = '4' },
            { s = 'C', r = '3' },
            { s = 'D', r = '3' },
            { s = 'H', r = '3' },
            { s = 'S', r = '3' },
            { s = 'C', r = '2' },
            { s = 'D', r = '2' },
            { s = 'H', r = '2' },
            { s = 'S', r = '2' },
        }
    },
}
SMODS.Challenge {
    key = "partikeo",
    rules = {
        custom = {
            { id = 'no_shop_jokers', }, -- value = true },
        },
        modifiers = {
            { id = 'joker_slots', value = 2 }
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'j_riff_raff' },
            { id = 'v_antimatter' },
            { id = 'p_buffoon_normal_1',   ids = { 'p_buffoon_normal_1', 'p_buffoon_normal_2', 'p_buffoon_jumbo_1', 'p_buffoon_mega_1', } },
            { id = 'c_judgement' },
            { id = 'c_wraith' },
            { id = 'c_soul' },
            { id = 'c_mannpower_plague' },
            { id = 'c_mannpower_supernova' },
        },
        banned_tags = {
            { id = 'tag_uncommon' },
            { id = 'tag_rare' },
            { id = 'tag_negative' },
            { id = 'tag_foil' },
            { id = 'tag_holographic' },
            { id = 'tag_polychrome' },
            { id = 'tag_buffoon' },
            { id = 'tag_top_up' },
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
