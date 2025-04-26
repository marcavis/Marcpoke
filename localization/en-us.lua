return {
    misc = {
        labels = {
            soccer_sticker = "Soccer",
            rebel_sticker = "Rebel",
            aging_sticker = "Aging",
        },
        dictionary = {
            poke_deenergized_ex = "Lost energy!",
            poke_poison_gas_ex = "Poison Gas!",
        },
        challenge_names = {
            c_marcpoke_convention_concern = "Convention Concern",
            c_marcpoke_graveyard_shift = "Graveyard Shift",
            c_marcpoke_onsen = "Onsen",
            c_marcpoke_unsuitable = "Unsuitable",
            c_marcpoke_porcelain_mayhem = "Porcelain Mayhem",
            c_marcpoke_purple_goo = "Purple Goo",
        },
        
        v_text = {
            ch_c_marcpoke_forced_finisher_boss_blind = {"The only finisher boss blind allowed"},
            ch_c_marcpoke_forced_finisher_boss_blind_2 = {"is {C:attention}Prismatic Purist{}"},
            ch_c_marcpoke_forced_finisher_boss_blind_3 = {"(Debuffs all cards and jokers"},
            ch_c_marcpoke_forced_finisher_boss_blind_4 = {"without editions; 8x mult requirement)"},
            ch_c_marcpoke_all_aging={"All Jokers are {C:attention}Aging{}"},
            -- ch_c_marcpoke_all_aging_2 = {"({C:inactive}{C:attention}Holding Energy{}; Can't evolve or gain energy){}"},
            ch_c_marcpoke_all_aging_2 = {"({C:inactive}Can't evolve or gain energy){}"},
            ch_c_marcpoke_all_perishable={"All Jokers are {C:attention}Perishable{}"},
            ch_c_marcpoke_playing_cards_free = {"Playing cards in the shop are free"}
        }
    },
    descriptions = {  
        Joker = {
            j_marcpoke_trubbish = {
                name = "Trubbish",
                text = {
                    "Gives {C:attention}+#1#%{} of",
                    "the chip value of the",
                    "remaining cards in deck",
                    "Currently: {C:chips}#3#{} chips",
                    "{C:inactive}(Evolves after {C:attention}#2#{}{C:inactive} rounds)"
                } 
            },
            j_marcpoke_garbodor = {
                name = "Garbodor",
                text = {
                    "Gives {C:attention}+#1#%{} of",
                    "the chip value of the",
                    "remaining cards in deck",
                    "Currently: {C:chips}#2#{} chips"
                } 
            },
            j_marcpoke_timburr = {
                name = "Timburr",
                text = {
                    "If scoring hand has at least two of",
                    "{C:attention}Stone{}, {C:attention}Steel{} or {C:attention}Glass{} cards,",
                    "gain {C:money}$#1#{}",
                    "{C:inactive,s:0.8}(Evolves at $#2#{C:inactive,s:0.8}/{C:money,s:0.8}$#3#{C:inactive,s:0.8} earned)",
                } 
            },
            j_marcpoke_gurdurr = {
                name = "Gurdurr",
                text = {
                    "If scoring hand has at least two of",
                    "{C:attention}Stone{}, {C:attention}Steel{} or {C:attention}Glass{} cards,",
                    "gain {C:money}$#1#{}",
                    "{C:inactive,s:0.8}(Evolves at $#2#{C:inactive,s:0.8}/{C:money,s:0.8}$#3#{C:inactive,s:0.8} earned)",
                } 
            },
            j_marcpoke_conkeldurr = {
                name = "Conkeldurr",
                text = {
                    "If scoring hand has at least two of",
                    "{C:attention}Stone{}, {C:attention}Steel{} or {C:attention}Glass{} cards, gain {C:money}$#1#{}",
                    "{br:2}text needs to be here to work",
                    "One-time effects:",
                    "3+ {C:attention}Stone{} cards: Gain +1 Joker slot",
                    "3+ {C:attention}Steel{} cards: Gain +1 consumable slot",
                    "3+ {C:attention}Glass{} cards: Gain +1 booster slot",
                } 
            },
            j_marcpoke_alolan_grimer = {
                name = "Alolan Grimer",
                text = {
                    "{C:mult}+#2#{} Mult",
                    "Destroys a random",
                    "unenhanced card every round",
                    "{br:2}text needs to be here to work",
                    "Can't reduce deck size below {C:attention}#3#{}",
                    "{C:inactive}(Evolves after {C:attention}#1#{}{C:inactive} rounds)"
                }
            },
            j_marcpoke_alolan_muk = {
                name = "Alolan Muk",
                text = {
                    "{C:mult}+#2#{} Mult",
                    "Destroys up to {C:mult}#1#{} random",
                    "unenhanced cards every round,",
                    "gaining {C:mult}+#3#{} Mult",
                    "{br:2}text needs to be here to work",
                    "Can't reduce deck size below {C:attention}#4#{}"
                }
            },
            j_marcpoke_yungoos = {
                name = "Yungoos",
                text = {
                    "Gain {C:money}$#2#{} when a card",
                    "with the targeted",
                    "rank and suit is scored",
                    "Current target: {C:attention}#1#{}",
                    "{C:inactive,s:0.8}(Target changes at blind selection){}",
                    "{C:inactive,s:0.8}(Evolves at $#3#{C:inactive,s:0.8}/{C:money,s:0.8}$#4#{C:inactive,s:0.8} earned)",
                }
            },
            j_marcpoke_gumshoos = {
                name = "Gumshoos",
                text = {
                    "If played hand contains a",
                    "{C:attention}Flush{}, draw up to {C:attention}#1#{} cards",
                    "with the targeted rank and suit",
                    "{br:2}text needs to be here to work",
                    "Gain {C:money}$#3#{} when target is scored",
                    "Current target: {C:attention}#2#{}",
                    "{C:inactive,s:0.8}(Target changes at blind selection){}",
                }
            },
            j_marcpoke_toxtricity_amped = {
                name = "Toxtricity (Amped)",
                text = {
                    "Increases the effectiveness",
                    "of {C:pink}Energy{} cards by {C:attention}50%{}"
                }
            },
            j_marcpoke_toxtricity_lowkey = {
                name = "Toxtricity (Low Key)",
                text = {
                    "When {C:attention}Small Blind{} is selected,",
                    "{C:inactive}or when a joker is destroyed{}(disabled)",
                    "create a {C:dark_edition}Negative{} {C:pink}Energy{} card",
                    "of its own type."
                }
            },
            j_marcpoke_joke_exploud = {
                name = "Joke Exploud",
                text = {
                    "Increases master",
                    "volume by 50%"
                }
            },
            j_marcpoke_chatot = {
                name = "Chatot",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "Gains {C:chips}+#2#{} Chips",
                    "whenever any Joker",
                    'or card "talks"'
                }
            },
            j_marcpoke_maractus = {
                name = "Maractus",
                text = {
                    "When a {C:attention}Lucky{} card triggers",
                    "its rewards improve",
                    "by {C:mult}+#1#{} Mult and {C:money}$#2#{}"
                }

            },
            j_marcpoke_luminous_cave = {
                name = "Luminous Cave",
                text = {
                    "{X:red,C:white}X#1#{} Mult",
                    "Gains {X:red,C:white}X#2#{} Mult",
                    "when a Joker evolves",
                }
            },
            j_marcpoke_johto_mom = {
                name = "Mom",
                text = {
                    "{C:mult}+#1#{} Mult",
                    "Gains {C:mult}+#2#{} Mult when cheering",
                    "{br:2}text needs to be here to work",
                    "Lose {C:attention}20%{} of end of round payout,",
                    "earning that as {C:attention}sell value{}",
                    -- "earning half of that as {C:attention}sell value{}",
                    -- "Buys random {C:dark_edition}Negative{} rare items",
                    "Buys random rare items when holding",
                    "more than {C:money}$#3#{} in sell value",
                }
            },
            j_marcpoke_cinderace = {
                name = "Cinderace",
                text = {
                    "{X:red,C:white}X#1#{} Mult when shooting",
                    "a soccer ball",
                    "{C:mult}+#2#{} Mult (testing)",
                    "Restores its soccer ball",
                    "sticker every blind",
                }
            },
            j_marcpoke_darkrai = {
                name = "Darkrai",
                text = {
                    "When {C:attention}Small Blind{} is selected,",
                    "create a {C:dark_edition}Nightmare{} spectral card",
                    "{C:inactive,s:0.8}(Must have room)",
                    "{br:2}text needs to be here to work",
                    "{C:attention}Energy{} cards in your consumable",
                    "area apply their effect to all",
                    "Jokers of the same type"
                }
            },
            j_marcpoke_snorlax_doll = {
                name = "Snorlax Doll",
                text = {
                    "Does nothing on its own",
                    -- "but acts as a real {C:attention}Snorlax{}",
                    -- "if (testing) {C:attention}Caterpie{} is present",
                }
            },
            j_marcpoke_clefairy_doll = {
                name = "Clefairy Doll",
                text = {
                    "Does nothing on its own",
                    -- "but acts as a real {C:attention}Clefairy{}",
                    -- "if (testing) {C:attention}Caterpie{} is present",
                }
            },
            j_marcpoke_scraggy = {
                name = "Scraggy",
                text = {
                    "Gives {C:attention}+#1#%{} of",
                    "the {C:chips}chip{}, {C:mult}mult{},",
                    "{X:red,C:white}Xmult{} and {C:money}money{}",
                    "bonuses from other jokers",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive}, {C:mult}+#3#{C:inactive}, {X:red,C:white}X#4#{C:inactive}, {C:money}$#5#{C:inactive} end of round)",
                    "{C:inactive}(Evolves after {C:attention}#6#{}{C:inactive} rounds with Joker slots full)"
                }
            },
            j_marcpoke_scrafty = {
                name = "Scrafty",
                text = {
                    "Gives {C:attention}+#1#%{} of",
                    "the {C:chips}chip{}, {C:mult}mult{},",
                    "{X:red,C:white}Xmult{} and {C:money}money{}",
                    "bonuses from other jokers",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive}, {C:mult}+#3#{C:inactive}, {X:red,C:white}X#4#{C:inactive}, {C:money}$#5#{C:inactive} end of round)",
                }
            },
            j_marcpoke_shuppet = {
                name = "Shuppet",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "{br:2}text needs to be here to work",
                    "Makes adjacent Dolls act like",
                    "the pokémon the represent",
                    "{br:2}text needs to be here to work",
                    "At the end of the round,",
                    "gain {C:chips}+#2#{} chips",
                    "for every disabled Joker or Doll",
                    "{C:inactive}(Evolves after {C:attention}#3#{}{C:inactive} rounds)",
                }
            },
            j_marcpoke_banette = {
                name = "Banette",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "{X:red,C:white}X#2#{} Mult",
                    "{br:2}text needs to be here to work",
                    "Makes all Dolls act like",
                    "the pokémon the represent",
                    "{br:2}text needs to be here to work",
                    "At the end of the round,",
                    "gains {C:chips}+#3#{} chips and {X:red,C:white}X#4#{} Mult",
                    "for every disabled Joker or Doll",
                }
            },
            j_marcpoke_super_nerd = {
                name = "Super Nerd",
                text = {
                    "Retriggers all scored cards with editions",
                }
            },
            j_marcpoke_sinistea = {
                name = 'Sinistea',
                text = {
                  "Leftmost {C:attention}Consumable{} gives",
                  "the effect it would apply on a card",
                --   "{C:inactive}Currently: #1#{}"
                }
            },
            j_marcpoke_sinistea2 = {
                name = 'Sinistea',
                text = {
                  "{C:money}Higher sale value{}",
                  "Leftmost {C:attention}Consumable{} gives",
                  "the effect it would apply on a card",
                --   "{C:inactive}Currently: #1#{}"
                }
            },
            j_marcpoke_polteageist = {
                name = 'Polteageist',
                text = {
                    "{C:attention}Holding {C:dark_edition}Negative{} Twisted Spoon{}",
                    "Every held {C:attention}Consumable{} gives",
                    "the effect it would apply on a card",
                }
            },
            j_marcpoke_polteageist2 = {
                name = 'Polteageist',
                text = {
                    "{C:money}Higher sale value{}",
                    "{C:attention}Holding {C:dark_edition}Negative{} Twisted Spoon{}",
                    "Every held {C:attention}Consumable{} gives",
                    "the effect it would apply on a card",
                }
            },
            j_marcpoke_mutant_polteageist = {
                name = 'Mutant Polteageist',
                text = {
                    "A rare, powerful Polteageist",
                    "that can be energized",
                    "{br:2}text needs to be here to work",
                    "Increases the number of consumable",
                    "slots to match its power",
                    "{br:2}text needs to be here to work",
                    "The first {C:mult}#1#{} {C:attention}Consumables{}",
                    "(rounded down) give",
                    "the effect they would apply on a card",
                }
            },
            j_marcpoke_stunky = {
                name = "Stunky",
                text = {
                    "{C:attention}Volatile Left{}",
                    "Reduces the score requirement",
                    "of the current blind by {C:attention}1%{}",
                    "per {C:money}${} of sell value of the",
                    "Joker to the right and debuffs it,",
                    "limited to a {C:attention}#2#%{} reduction",
                    "Currently: {C:attention}#1#%{} reduction",
                    "{C:inactive}(Evolves after {C:attention}#3#{}{C:inactive} rounds)"
                }
            },
            j_marcpoke_skuntank = {
                name = "Skuntank",
                text = {
                    "{C:attention}Volatile Left{}",
                    "Reduces the score requirement",
                    "of the current blind by {C:attention}2%{}",
                    "(or {C:attention}3%{} when debuffing a {X:fire,C:white}Fire{} type Joker)",
                    "per {C:money}${} of sell value of the",
                    "Joker to the right and debuffs it,",
                    "limited to a {C:attention}#2#%{} reduction",
                    "Currently: {C:attention}#1#%{} reduction",
                }
            }
        },
        Blind = {
            bl_marcpoke_ppurist = {
                name = "Prismatic Purist",
                text = {
                    "Jokers and cards",
                    "without special editions",
                    "are debuffed"
                }, 
            },
        },
        Item = {
            c_marcpoke_bills_pc = {
                name = "Bill's PC",
                text = {
                    "{C:dark_edition}+#1#{} Joker slot",
                    "{C:dark_edition}+#2#{} consumable slot",
                    "Benches (debuffs) the rightmost joker",
                    "Can't be sold when joker slots are filled"
                }
            },
            c_marcpoke_repel = {
                name = "Repel",
                text = {
                    "Prevents the appearance",
                    "of common jokers for {C:attention}#1#{} rerolls",
                    "Expires when you leave shop"
                }
            }
        },
        Other = {
            haunted_strange = {
                name = "Failed to Haunt",
                text = {
                    "#1# didn't know",
                    "what to do with {C:attention}#2#{}"
                }
            },
            haunted_planet = {
                name = "Haunted Planet",
                text = {
                    "Haunted {C:Planet}#2#{} gives",
                    "{C:mult}+#4#{} Mult and",
                    "{C:chips}+#3#{} chips"
                }
            },
            --fool, emperor, lovers, strength, hangman, death, star, moon, sun, world?
            haunted_c_magician = {
                name = "Haunting Magician",
                text = {
                    "Held Magician gives",
                    "{C:green}#3# in #4#{} chance",
                    "for {C:mult}+20{} Mult",
                }
            },
            haunted_c_high_priestess = {
                name = "Haunting High Priestess",
                text = {
                    "Held High Priestess gives",
                    "{C:mult}+2{} Mult and",
                    "{C:chips}+25{} chips"
                }
            },
            haunted_c_empress = {
                name = "Haunting Empress",
                text = {
                    "Held Empress gives",
                    "{C:mult}+4{} Mult"
                }
            },
            haunted_c_heirophant = {
                name = "Haunting Hierophant",
                text = {
                    "Held Hierophant gives",
                    "{C:chips}+30{} chips"
                }
            },
            haunted_c_chariot = {
                name = "Haunting Chariot",
                text = {
                    "Held Chariot gives",
                    "{X:red,C:white}X1.5{} Mult"
                }
            },
            haunted_c_justice = {
                name = "Haunting Justice",
                text = {
                    "Held Justice gives",
                    "{X:red,C:white}X2{} Mult",
                    "{C:green}#3# in #4#{} chance to",
                    "destroy Justice card",
                }
            },
            haunted_c_hermit = {
                name = "Haunting Hermit",
                text = {
                    "Held Hermit gives",
                    "{C:money}$3{} at the",
                    "end of round"
                }
            },
            haunted_c_wheel_of_fortune = {
                name = "Haunting Wheel of Fortune",
                text = {
                    "Held Wheel of Fortune gives",
                    "{C:green}#3# in #4#{} chance for",
                    "{C:chips}+50{} chips,",
                    "{C:mult}+10{} Mult, or",
                    "{X:red,C:white}X1.5{} Mult",                    
                }
            },
            haunted_c_temperance = {
                name = "Haunting Temperance",
                text = {
                    "Held Temperance gives",
                    "{C:money}$3{} at the",
                    "end of round"
                }
            },
            haunted_c_devil = {
                name = "Haunting Devil",
                text = {
                    "Held Devil gives",
                    "{C:money}$3{} at the",
                    "end of round"
                }
            },
            haunted_c_tower = {
                name = "Haunting Tower",
                text = {
                    "Held Tower gives",
                    "{C:chips}+50{} chips"
                }
            },
            haunted_c_talisman = {
                name = "Haunting Talisman",
                text = {
                    "Held Talisman gives",
                    "{C:money}$3{} at the",
                    "end of round"
                }
            },
            haunted_c_aura = {
                name = "Haunting Aura",
                text = {
                    "Held Aura gives",
                    "{C:chips}+50{} chips,",
                    "{C:mult}+10{} Mult, or",
                    "{X:red,C:white}X1.5{} Mult",                    
                }
            },
            haunted_c_poke_upgrade = {
                name = "Haunting Upgrade",
                text = {
                    "Held Upgrade gives",
                    "{C:chips}+50{} chips,",
                    "{C:mult}+10{} Mult, or",
                    "{X:red,C:white}X1.5{} Mult",                    
                }
            },
            haunted_c_poke_dubiousdisc = {
                name = "Haunting Dubious Disc",
                text = {
                    "Held Dubious Disc gives",
                    "{C:chips}+50{} chips,",
                    "{C:mult}+10{} Mult, or",
                    "{X:red,C:white}X1.5{} Mult",                    
                }
            },
            haunted_c_sigil = {
                name = "Haunting Sigil",
                text = {
                    "Held Sigil gives",
                    "{X:red,C:white}X2{} Mult",
                    "if played hand",
                    "contains a {C:attention}Flush{}"
                }
            },
            haunted_c_ouija = {
                name = "Haunting Ouija",
                text = {
                    "Held Ouija gives",
                    "{X:red,C:white}X2{} Mult",
                    "if played hand",
                    "contains a {C:attention}Four of a Kind{}"
                }
            },
            haunted_c_immolate = {
                name = "Haunting Immolate",
                text = {
                    "Held Immolate gives",
                    "{C:money}$3{} at the",
                    "end of round"
                }
            },
            haunted_c_deja_vu = {
                name = "Haunting Deja Vu",
                text = {
                    "Held Deja Vu causes",
                    "the leftmost scoring card",
                    "to be retriggered once",
                }
            },
            haunted_c_hex = {
                name = "Haunting Hex",
                text = {
                    "Held Hex gives",
                    "{X:red,C:white}X1.5{} Mult"
                }
            },
            haunted_c_poke_metalcoat = {
                name = "Haunting Metal Coat",
                text = {
                    "Held Metal Coat gives",
                    "{X:red,C:white}X1.5{} Mult"
                }
            },
            haunted_c_poke_waterstone = {
                name = "Haunting Water Stone",
                text = {
                    "Held Water Stone gives",
                    "{C:chips}+30{} chips"
                }
            },
            haunted_c_poke_leafstone = {
                name = "Haunting Leaf Stone",
                text = {
                    "Held Magician gives",
                    "{C:green}#3# in #4#{} chance",
                    "for {C:mult}+20{} Mult",
                }
            },
            haunted_c_poke_firestone = {
                name = "Haunting Fire Stone",
                text = {
                    "Held Fire Stone gives",
                    "{C:red}+8{} Mult"
                }
            },
            haunted_c_poke_thunderstone = {
                name = "Haunting Thunder Stone",
                text = {
                    "Held Thunder Stone gives",
                    "{C:money}$3{} at the",
                    "end of round"
                }
            },
            haunted_c_poke_icestone = {
                name = "Haunting Ice Stone",
                text = {
                    "Held Ice Stone gives",
                    "{X:red,C:white}X2{} Mult",
                    "{C:green}#3# in #4#{} chance to",
                    "destroy Ice Stone card",
                }
            },
            haunted_c_poke_shinystone = {
                name = "Haunting Shiny Stone",
                text = {
                    "Held Shiny Stone gives",
                    "{C:money}$3{} at the",
                    "end of round"
                }
            },
            haunted_c_poke_duskstone = {
                name = "Haunting Dusk Stone",
                text = {
                    "Held Dusk Stone gives",
                    "{C:money}$3{} at the",
                    "end of round"
                }
            },
            haunted_c_poke_leftovers = {
                name = "Haunting Leftovers",
                text = {
                    "Held Leftovers give",
                    "{C:money}$2{} at the",
                    "end of round"
                }
            },
            haunted_steel = {
                name = "Haunted Item",
                text = {
                    "Held {C:attention}#2#{} gives",
                    "{X:red,C:white}X1.5{} Mult"
                }
            },
            moms_shopping_list = {
                name = "Mom's Shopping List",
                text = {
                    -- "{C:green}10%{} - {X:water,C:white}Salon visit!{}",
                    -- "{C:inactive,s:0.8}(Gives a random edition to a joker){C:inactive,s:0.8})",
                    "{C:green}10%{} - {C:attention}Makeover!{} (becomes {C:attention}Polychrome{})",
                    "{C:green}10%{} - {C:attention}Usable Evolution Card{}",
                    "{C:green}20%{} - {C:attention}Random Evolution Card{}",
                    "{C:green}20%{} - {C:attention}Pokemon Doll{}",
                    "{C:green}20%{} - {C:attention}Random Berries{}",
                    "{C:green}19%{} - {C:attention}Repel{}",
                    "{C:green}1%{} - {C:attention}Mega Stone{}",
                    "{C:attention}Unable to buy{} - Cheer (gain Mult)",
                }
            },
            soccer_sticker = {
                name = "Soccer Ball",
                text = {
                    "If played hand has {X:attention,C:white}9s{} :",
                    "Cinderace shoots it!",
                    "Each {X:attention,C:white}9{} adds {X:red,C:white}X#3#{} to shot",
                    "{br:2}text needs to be here to work",
                    "Each {X:attention,C:white}10{} : +{X:red,C:white}X#1#{} mult",
                    "Has {X:attention,C:white}Ace{} : Multiplies the {X:red,C:white}X{} mult", 
                    "of the next shot by {X:red,C:white}X#2#{} mult",
                },
            },
            rebel_sticker = {
                name = "Rebel",
                text = {
                    "The values on this",
                    "joker are reversed",
                },
            },
            aging_sticker = {
                name = "Aging",
                text = {
                    -- "{C:attention}Holding Energy{}",
                    "Can't evolve or gain energy",
                },
            }
        }
    }
}

            -- j_marcpoke_test_magmar = {
            --     name = 'Test Magmar',      
            --     text = {
            --         "If {C:attention}first discard{} of round has only",
            --         "{C:attention}1{} card, destroy it and gain {C:mult}+#2#{} Mult",
            --         "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
            --         "{C:inactive,s:0.8}(Evolves with a {C:attention,s:0.8}Linking Cord{C:inactive,s:0.8})"
            --     } 
            -- },