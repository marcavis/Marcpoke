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
            {id = 'bl_marcpoke_ppurist', type = 'blind'},
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
            {id = 'bl_marcpoke_ppurist', type = 'blind'},
        }
    },
    deck = {
      type = 'Challenge Deck',
    },
}
return {name = "Challenges", 
        list = {convention_concern, graveyard_shift, onsen}
}