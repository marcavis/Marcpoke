return {
    descriptions = {
        Joker = {
            j_marcpoke_chikorita = {
                name = "Chikorita",
                text = {
                    "{C:attention}+#4#{} hand size",
                    "{C:mult}#3# discards{}",
                    "Earn {C:money}$#1#{} for each",
                    "discarded hand",
                    "{C:inactive,s:0.8}(Evolves at $#2#{C:inactive,s:0.8}/{C:money,s:0.8}$#5#{C:inactive,s:0.8} earned)",
                } 
            },
            j_marcpoke_bayleef = {
                name = "Bayleef",
                text = {
                    "{C:attention}+#4#{} hand size",
                    "{C:mult}#3# discards{}",
                    "Earn {C:money}$#1#{} for each",
                    "discarded hand",
                    "{C:inactive,s:0.8}(Evolves at $#2#{C:inactive,s:0.8}/{C:money,s:0.8}$#5#{C:inactive,s:0.8} earned)",
                } 
            },
            j_marcpoke_meganium = {
                name = "Meganium",
                text = {
                    "{C:attention}+#3#{} hand size",
                    "Earn {C:money}$#1#{} for each",
                    "discarded hand",
                } 
            },
            j_marcpoke_trubbish = {
                name = "Trubbish",
                text = {
                    "Gives {C:attention}+#1#%{} of",
                    "the chip value of the",
                    "remaining cards in deck",
                    "{C:inactive}(Evolves after {C:attention}#2#{}{C:inactive} rounds)"
                } 
            },
            j_marcpoke_garbodor = {
                name = "Garbodor",
                text = {
                    "Gives {C:attention}+#1#%{} of",
                    "the chip value of the",
                    "remaining cards in deck"
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
            j_marcpoke_toxtricity = {
                name = "Toxtricity",
                text = {
                    "Increases the effect",
                    "of energy cards by 50%"
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
                    "{C:green}#1# in #2#{} chance to",
                    "improve the reward",
                    "of scored {C:attention}Lucky{} cards",
                    "by {C:mult}+#3#{} Mult and {C:money}$#4#{}"
                }

            },
            j_marcpoke_luminous_cave = {
                name = "Luminous Cave",
                text = {
                    "{X:red,C:white}X#1#{} Mult",
                    "Gains {X:red,C:white}X#2#{} Mult",
                    "when a Joker evolves",
                }
            }

        }
    }
}

-- j_poke_bulbasaur = {
--     name = "Bulbasaur",
--     text = {
--         "{C:attention}+#4#{} hand size",
--         "Earn {C:money}$#1#{} for each",
--         "{C:attention}#3#{} held in hand",
--         "{C:inactive,s:0.8}(Rank changes every round){}",
--         "{C:inactive,s:0.8}(Evolves at $#2#{C:inactive,s:0.8}/{C:money,s:0.8}$16{C:inactive,s:0.8} earned)",
--     } 
-- },

-- j_poke_arcanine = {
--     name = "Arcanine",
--     text = {
--         "{X:red,C:white} X#1# {} Mult if played hand",
--         "contains a {C:attention}Flush{}",
--         "{br:2}text needs to be here to work",
--         "Create a {C:attention}Lovers{} card",
--         "when {C:attention}Blind{} is selected"
--     } 
-- },

-- text = {
--     "Played cards with",
--     "{C:diamonds}#3#{} suit give",
--     "{C:mult}+#1#{} Mult and ",
--     "{C:money}$#2#{} when scored",
-- } 