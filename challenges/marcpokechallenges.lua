local convention_concern = {
    object_type = "Challenge",
    key = "convention_concern",
    rules = {
        custom = {
            {id = 'marcpoke_forced_finisher_boss_blind'},
            {id = 'marcpoke_forced_finisher_boss_blind_2'},
            {id = 'marcpoke_forced_finisher_boss_blind_3'},
            {id = 'marcpoke_forced_finisher_boss_blind_4'},
        },
        modifiers = {
        }
    },
    vouchers = {
        {id = 'v_hone'},
        {id = 'v_glow_up'},
    },
    jokers = {
      {id = "j_marcpoke_super_nerd", eternal = true},
    },
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
        },
        banned_other = {
            {id = 'bl_final_heart', type = 'blind'},
            {id = 'bl_final_leaf', type = 'blind'},
            {id = 'bl_final_acorn', type = 'blind'},
            {id = 'bl_final_vessel', type = 'blind'},
            {id = 'bl_final_bell', type = 'blind'},
            {id = 'bl_poke_cgoose', type = 'blind'},
        }
    },
    deck = {
      type = 'Challenge Deck',
    },
}
local graveyard_shift = {
    object_type = "Challenge",
    key = "graveyard_shift",
    rules = {
        custom = {
            {id = 'marcpoke_all_perishable'},
        },
        modifiers = {
        }
    },
    vouchers = {
    },
    jokers = {
      {id = "j_marcpoke_shuppet", eternal = true},
    },
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
        },
        banned_other = {
        }
    },
    deck = {
      type = 'Challenge Deck',
    },
}
local onsen = {
    object_type = "Challenge",
    key = "onsen",
    rules = {
        custom = {
            {id = 'marcpoke_all_aging'},
            {id = 'marcpoke_all_aging_2'},
        },
        modifiers = {
        }
    },
    vouchers = {
    },
    jokers = {
      {id = "j_poke_mudkip", eternal = true},
      --Torkoal?
    },
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
        },
        banned_other = {

        }
    },
    deck = {
      type = 'Challenge Deck',
    },
}
local unsuitable = {
    object_type = "Challenge",
    key = "unsuitable",
    rules = {
        custom = {
            
        },
        modifiers = {
        }
    },
    consumeables = {
        {id = 'c_lovers'}
    },
    vouchers = {
    },
    jokers = {
      {id = "j_poke_staryu", eternal = true},
      {id = "j_poke_exeggcute", eternal = true},
      {id = "j_poke_cleffa", eternal = true},
      {id = "j_poke_igglybuff", eternal = true},
    },
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
        },
        banned_other = {
            {id = 'bl_final_heart', type = 'blind'},
            {id = 'bl_final_leaf', type = 'blind'},
            {id = 'bl_head', type = 'blind'},
            {id = 'bl_window', type = 'blind'},
            {id = 'bl_goad', type = 'blind'},
            {id = 'bl_club', type = 'blind'},
        }
    },
    deck = {
      type = 'Challenge Deck',
    },
}
local porcelain_mayhem = {
    object_type = "Challenge",
    key = "porcelain_mayhem",
    rules = {
        custom = {
            {id = 'no_shop_jokers'},
        },
        modifiers = {
            {id = 'joker_slots', value = 1},
        }
    },
    consumeables = {
        
    },
    vouchers = {
        {id = 'v_crystal_ball'}
    },
    jokers = {
      {id = "j_marcpoke_mutant_polteageist", eternal = true},
    },
    restrictions = {
        banned_cards = {
            {id = 'c_judgement'},
            {id = 'c_poke_pokeball'},
            {id = 'c_poke_greatball'},
            {id = 'c_poke_ultraball'},
            {id = 'c_poke_masterball'},
            {id = 'c_wraith'},
            {id = 'c_soul'},
            {id = 'v_blank'},
            {id = 'v_antimatter'},
            {id = 'p_buffoon_normal_1', ids = {
                'p_buffoon_normal_1','p_buffoon_normal_2','p_buffoon_jumbo_1','p_buffoon_mega_1',
            }},
        },
        banned_tags = {
            {id = 'tag_rare'},
            {id = 'tag_uncommon'},
            {id = 'tag_holo'},
            {id = 'tag_polychrome'},
            {id = 'tag_negative'},
            {id = 'tag_foil'},
            {id = 'tag_buffoon'},
            {id = 'tag_top_up'},
            {id = 'tag_poke_shiny_tag'},
            {id = 'tag_poke_stage_one_tag'},
            {id = 'tag_poke_safari_tag'}
        },
        banned_other = {
            {id = 'bl_final_heart', type = 'blind'},
            {id = 'bl_final_leaf', type = 'blind'},
            {id = 'bl_poke_cgoose', type = 'blind'},
        }
    },
    deck = {
      type = 'Challenge Deck',
    },
}
return {name = "Challenges", 
        list = {convention_concern, graveyard_shift, onsen, unsuitable, porcelain_mayhem}
}