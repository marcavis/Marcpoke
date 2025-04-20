local purple_goo = {
    object_type = "Challenge",
    key = "purple_goo",
    rules = {
        custom = {
            {id = 'marcpoke_playing_cards_free'},
        },
        modifiers = {
            {id = 'hand_size', value = 6},
        }
    },
    consumeables = {
        
    },
    vouchers = {
        {id = 'v_hone'},
        {id = 'v_glow_up'},
        {id = 'v_magic_trick'},
        {id = 'v_illusion'}
    },
    jokers = {
      {id = "j_poke_muk", eternal = true},
      {id = "j_poke_jynx", eternal = true, edition = 'negative'},
      {id = "j_poke_jynx", eternal = true, edition = 'negative'},
    },
    restrictions = {
        banned_cards = {
            -- {id = 'c_judgement'},
            -- {id = 'c_poke_pokeball'},
            -- {id = 'c_poke_greatball'},
            -- {id = 'c_poke_ultraball'},
            -- {id = 'c_poke_masterball'},
            -- {id = 'c_wraith'},
            -- {id = 'c_soul'},
            -- {id = 'v_blank'},
            -- {id = 'v_antimatter'},
            -- {id = 'p_buffoon_normal_1', ids = {
            --     'p_buffoon_normal_1','p_buffoon_normal_2','p_buffoon_jumbo_1','p_buffoon_mega_1',
            -- }},
        },
        banned_tags = {
        },
        banned_other = {
            {id = 'bl_final_leaf', type = 'blind'},
        }
    },
    deck = {
      type = 'Challenge Deck',
    },
}
return {name = "Challenges", 
        list = {purple_goo}
}