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
