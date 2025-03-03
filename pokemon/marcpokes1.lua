-- Swadloon 541
-- Leavanny 542
-- Venipede 543
-- Whirlipede 544
-- Scolipede 545
-- Cottonee 546
-- Whimsicott 547
-- Petilil 548
-- Lilligant 549
-- Basculin 550
-- Sandile 551
-- Krokorok 552
-- Krookodile 553
-- Darumaka 554
-- Darmanitan 555
-- Maractus 556
-- Dwebble 557
-- Crustle 558
-- Scraggy 559
-- Scrafty 560
-- Sigilyph 561
-- Yamask 562
-- Cofagrigus 563
-- Tirtouga 564
-- Carracosta 565
-- Archen 566
-- Archeops 567
-- Trubbish 568
local trubbish = {
        name = "trubbish",
        poke_custom_prefix = "marcpoke",
        pos = {x = 4, y = 5}, 
        config = {extra = {chips = 10, rounds = 5}},
        loc_vars = function(self, info_queue, center)
          type_tooltip(self, info_queue, center)
          return {vars = {center.ability.extra.chips, center.ability.extra.rounds}}
        end,
        rarity = 2, 
        cost = 4,
        ptype = "Dark",
        stage = "Basic", 
        set_sprites = function(self, card, front)
            card.config.center.atlas = "poke_Pokedex5"
            card.children.center.atlas = G.ASSET_ATLAS['poke_Pokedex5']
            card.children.center:reset()
        end,
        blueprint_compat = true,
        calculate = function(self, card, context)
            if context.cardarea == G.jokers and context.scoring_hand then
                if context.joker_main and #G.deck.cards > 0 then
                    local chipSum = 0
                    for k, v in pairs(G.deck.cards) do
                        local total_chips = poke_total_chips(v)
                        chipSum = chipSum + total_chips
                    end
                    return {
                        message = localize{type = 'variable', key = 'a_chips', vars = {(card.ability.extra.chips/100) * chipSum}}, 
                        colour = G.C.CHIPS,
                        chip_mod = (card.ability.extra.chips/100) * chipSum
                    }
                end
            end
            return level_evo(self, card, context, "j_marcpoke_garbodor")
        end
      }
-- Garbodor 569
local garbodor = {
    name = "garbodor",
    poke_custom_prefix = "marcpoke",
    pos = {x = 5, y = 5}, 
    config = {extra = {chips = 25}},
    loc_vars = function(self, info_queue, center)
      type_tooltip(self, info_queue, center)
      return {vars = {center.ability.extra.chips}}
    end,
    rarity = 2, 
    cost = 4,
    ptype = "Dark",
    stage = "One", 
    set_sprites = function(self, card, front)
        card.config.center.atlas = "poke_Pokedex5"
        card.children.center.atlas = G.ASSET_ATLAS['poke_Pokedex5']
        card.children.center:reset()
    end,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand then
            if context.joker_main and #G.deck.cards > 0 then
                local chipSum = 0
                for k, v in pairs(G.deck.cards) do
                    local total_chips = poke_total_chips(v)
                    chipSum = chipSum + total_chips
                end
                return {
                    message = localize{type = 'variable', key = 'a_chips', vars = {(card.ability.extra.chips/100) * chipSum}}, 
                    colour = G.C.CHIPS,
                    chip_mod = (card.ability.extra.chips/100) * chipSum
                }
            end
        end
    end
  }
-- Zorua 570

local timburr = {
    name = "timburr", 
    poke_custom_prefix = "marcpoke",
    pos = {x = 10, y = 2}, 
    config = {extra = {money = 2, earned = 0, dollars_required = 8}},
    loc_vars = function(self, info_queue, center)
      type_tooltip(self, info_queue, center)
      return {vars = {center.ability.extra.money, center.ability.extra.earned, center.ability.extra.dollars_required}}
    end,
    rarity = 2, 
    cost = 4,
    ptype = "Fighting",
    stage = "Basic", 
    set_sprites = function(self, card, front)
        card.config.center.atlas = "poke_Pokedex5"
        card.children.center.atlas = G.ASSET_ATLAS['poke_Pokedex5']
        card.children.center:reset()
    end,
    enhancement_gate = 'm_stone',
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand then
            if context.joker_main then
                local material_count = 0
                for i = 1, #context.scoring_hand do
                    if context.scoring_hand[i].ability.name == 'Stone Card' or
                    context.scoring_hand[i].ability.name == 'Steel Card' or
                    context.scoring_hand[i].ability.name == 'Glass Card' then
                        if not context.scoring_hand[i].debuff then
                            material_count = material_count + 1    
                        end
                    end
                end
                if material_count >= 2 then
                    local earned = ease_poke_dollars(card, "timburr", card.ability.extra.money, true)
                    card.ability.extra.earned = card.ability.extra.earned + earned
                    return {
                        dollars = earned
                    }
                end
            end
        end
        return scaling_evo(self, card, context, "j_marcpoke_gurdurr", card.ability.extra.earned, card.ability.extra.dollars_required)
      end,
  }

  local gurdurr = {
    name = "gurdurr", 
    poke_custom_prefix = "marcpoke",
    pos = {x = 11, y = 2}, 
    config = {extra = {money = 3, earned = 0, dollars_required = 20}},
    loc_vars = function(self, info_queue, center)
      type_tooltip(self, info_queue, center)
      return {vars = {center.ability.extra.money, center.ability.extra.earned, center.ability.extra.dollars_required}}
    end,
    rarity = 2, 
    cost = 4,
    ptype = "Fighting",
    stage = "One", 
    set_sprites = function(self, card, front)
        card.config.center.atlas = "poke_Pokedex5"
        card.children.center.atlas = G.ASSET_ATLAS['poke_Pokedex5']
        card.children.center:reset()
    end,
    enhancement_gate = 'm_stone',
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand then
            if context.joker_main then
                local material_count = 0
                for i = 1, #context.scoring_hand do
                    if context.scoring_hand[i].ability.name == 'Stone Card' or
                    context.scoring_hand[i].ability.name == 'Steel Card' or
                    context.scoring_hand[i].ability.name == 'Glass Card' then
                        if not context.scoring_hand[i].debuff then
                            material_count = material_count + 1    
                        end
                    end
                end
                if material_count >= 2 then
                    local earned = ease_poke_dollars(card, "gurdurr", card.ability.extra.money, true)
                    card.ability.extra.earned = card.ability.extra.earned + earned
                    return {
                        dollars = earned
                    }
                end
            end
        end
        return scaling_evo(self, card, context, "j_marcpoke_conkeldurr", card.ability.extra.earned, 18)
    end
  }

  local conkeldurr = {
    name = "conkeldurr", 
    poke_custom_prefix = "marcpoke",
    pos = {x = 12, y = 2}, 
    config = {extra = {
        money = 4, earned = 0,
        stone_quest = false, steel_quest = false, glass_quest = false,
        stone_reward = false, steel_reward = false, glass_reward = false
    }},
    loc_vars = function(self, info_queue, center)
      type_tooltip(self, info_queue, center)
      return {vars = {center.ability.extra.money, center.ability.extra.earned}}
    end,
    rarity = "poke_safari", 
    cost = 4,
    ptype = "Fighting",
    stage = "Two", 
    set_sprites = function(self, card, front)
        card.config.center.atlas = "poke_Pokedex5"
        card.children.center.atlas = G.ASSET_ATLAS['poke_Pokedex5']
        card.children.center:reset()
    end,
    enhancement_gate = 'm_stone',
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand then
            if context.joker_main then
                local material_count = 0
                local materials = {
                    ['Stone Card'] = 0,
                    ['Steel Card'] = 0,
                    ['Glass Card'] = 0
                }
                for i = 1, #context.scoring_hand do
                    local cardtype = context.scoring_hand[i].ability.name
                    if not context.scoring_hand[i].debuff then
                        if cardtype == "Stone Card" or cardtype == "Steel Card" or cardtype == "Glass Card" then
                            materials[cardtype] = materials[cardtype] + 1
                            material_count = material_count + 1
                        end
                    end
                end
                if materials['Stone Card'] >= 3 then card.ability.extra.stone_quest = true end
                if materials['Steel Card'] >= 3 then card.ability.extra.steel_quest = true end
                if materials['Glass Card'] >= 3 then card.ability.extra.glass_quest = true end
                if material_count >= 2 then
                    local earned = ease_poke_dollars(card, "conkeldurr", card.ability.extra.money, true)
                    card.ability.extra.earned = card.ability.extra.earned + earned
                    return {
                        dollars = earned
                    }
                end
            end
        elseif context.cardarea == G.jokers and context.end_of_round then
            if card.ability.extra.stone_quest and not card.ability.extra.stone_reward then
                card.ability.extra.stone_reward = true
                G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                return {
                    message = "House Built!"
                }
            elseif card.ability.extra.steel_quest and not card.ability.extra.steel_reward then
                card.ability.extra.steel_reward = true
                G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
                return {
                    message = "Storeroom Built!"
                }
            elseif card.ability.extra.glass_quest and not card.ability.extra.glass_reward then
                card.ability.extra.glass_reward = true
                if G.GAME.modifiers.poke_booster_packs then
                    G.GAME.modifiers.poke_booster_packs = G.GAME.modifiers.poke_booster_packs + 1
                else
                    G.GAME.modifiers.poke_booster_packs = 3
                end
                return {
                    message = "Shop Built!"
                }
            end
        end
    end
  }

  local alolan_grimer={
    name = "alolan_grimer", 
    pos = {x = 9, y = 6}, 
    config = {extra = {mult = 8, minimum_deck_size = 24, rounds = 5}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.rounds,
        center.ability.extra.mult, center.ability.extra.minimum_deck_size}}
    end,
    rarity = 1, 
    cost = 4, 
    stage = "One", 
    ptype = "Dark",
    set_sprites = function(self, card, front)
        card.config.center.atlas = "poke_Pokedex1"
        card.children.center.atlas = G.ASSET_ATLAS['poke_Pokedex1']
        card.children.center:reset()
    end,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand then
            if context.joker_main then
                return {
                    message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
                    colour = G.C.MULT,
                    mult_mod = card.ability.extra.mult
                }
            end
        end
        if context.end_of_round and not context.individual and not context.repetition then
            local targets = {}
            for _, deckcard in ipairs(G.playing_cards) do
                if deckcard.ability.effect == "Base" then
                    table.insert(targets, deckcard)
                end
            end
            --the first Alolan Grimer/Muk will centralize all deletions, to avoid deleting beyond the minimum deck size
            local alolangrimers = SMODS.find_card(card.config.center.key)
            if card == alolangrimers[1] then
                local actually_removed = {}
                pseudoshuffle(targets, pseudoseed("grimer"))
                local amount_to_delete = math.min(#targets, 
                                                #alolangrimers,
                                                #G.playing_cards - card.ability.extra.minimum_deck_size)
                for j = 1, amount_to_delete do
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function()
                            table.insert(actually_removed, targets[j])
                            targets[j]:start_dissolve()
                        return true end }))
                end
                delay(0.3)
                for i = 1, #G.jokers.cards do
                    for j = 1, #actually_removed do
                        G.jokers.cards[i]:calculate_joker({remove_playing_cards = true, removed = {actually_removed[j]}})
                    end
                end
                
                for _, grimer in ipairs(alolangrimers) do
                    grimer:juice_up()
                end
            end
        end
        return level_evo(self, card, context, "j_marcpoke_alolan_muk")
    end,
}

local alolan_muk={
    name = "alolan_muk", 
    pos = {x = 10, y = 6}, 
    config = {extra = {mult = 0, mult_mod = 4, targets = 2, minimum_deck_size = 20}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.targets,
        center.ability.extra.mult, center.ability.extra.mult_mod, center.ability.extra.minimum_deck_size}}
    end,
    rarity = 3, 
    cost = 8, 
    stage = "One", 
    ptype = "Dark",
    set_sprites = function(self, card, front)
        card.config.center.atlas = "poke_Pokedex1"
        card.children.center.atlas = G.ASSET_ATLAS['poke_Pokedex1']
        card.children.center:reset()
    end,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand then
            if context.joker_main then
                return {
                    message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
                    colour = G.C.MULT,
                    mult_mod = card.ability.extra.mult
                }
            end
        end
        if context.end_of_round and not context.individual and not context.repetition then
            local targets = {}
            for _, deckcard in ipairs(G.playing_cards) do
                if deckcard.ability.effect == "Base" then
                    table.insert(targets, deckcard)
                end
            end
            --the first Alolan Grimer/Muk will centralize all deletions, to avoid deleting beyond the minimum deck size
            local alolanmuks = SMODS.find_card(card.config.center.key)
            if card == alolanmuks[1] then
                local actually_removed = {}
                pseudoshuffle(targets, pseudoseed("muk"))
                local amount_to_delete = math.min(#targets, 
                                                card.ability.extra.targets * #alolanmuks,
                                                #G.playing_cards - card.ability.extra.minimum_deck_size)
                for j = 1, amount_to_delete do
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function()
                            table.insert(actually_removed, targets[j])
                            targets[j]:start_dissolve()
                            --if a Muk deleted at least one card, it gets upgraded
                            local upgraded_muk_index = math.ceil(#actually_removed/card.ability.extra.targets) --targets is 2, usually
                            local upg_muk = alolanmuks[upgraded_muk_index]
                            if math.fmod(#actually_removed,2) == 1 then
                                upg_muk.ability.extra.mult = upg_muk.ability.extra.mult + upg_muk.ability.extra.mult_mod
                                card_eval_status_text(upg_muk, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.BLUE})
                            end
                        return true end }))
                end
                delay(0.3)
                for i = 1, #G.jokers.cards do
                    for j = 1, #actually_removed do
                        G.jokers.cards[i]:calculate_joker({remove_playing_cards = true, removed = {actually_removed[j]}})
                    end
                end
                
                for _, muk in ipairs(alolanmuks) do
                    muk:juice_up()
                end
            end
        end
    end,
}

local yungoos = {
    name = "yungoos", 
    pos = {x = 12, y = 0}, 
    
    config = {extra = {money_mod = 4, target_rank = "Ace", target_suit = "Spades", target_id = 14, earned = 0, dollars_required = 8}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.target_rank .. " of " .. center.ability.extra.target_suit,
                center.ability.extra.money_mod, center.ability.extra.earned, center.ability.extra.dollars_required}}
    end,
    rarity = 1, 
    cost = 4, 
    stage = "One", 
    ptype = "Colorless",
    set_sprites = function(self, card, front)
        card.config.center.atlas = "poke_Pokedex7"
        card.children.center.atlas = G.ASSET_ATLAS['poke_Pokedex7']
        card.children.center:reset()
    end,
    blueprint_compat = true,
    add_to_deck = function(self, card, from_debuff)
        reset_gumshoos_card(card)
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            reset_gumshoos_card(card)
        end
        if context.individual and context.cardarea == G.play then
            --Maybe it works even if the card is debuffed...
            --if (not context.other_card.debuff) and
            if  (context.other_card:get_id() == card.ability.extra.target_id) and 
            (context.other_card:is_suit(card.ability.extra.target_suit)) then
                local earned = 0
                if not context.blueprint then
                    card.ability.extra.earned = card.ability.extra.earned + card.ability.extra.money_mod
                end
                earned = earned + card.ability.extra.money_mod
                earned = ease_poke_dollars(card, "yungoos", earned)
                return {
                    message = localize('$')..earned,
                    colour = G.C.MONEY,
                    card = card
                }
            end
        end
        return scaling_evo(self, card, context, "j_marcpoke_gumshoos", card.ability.extra.earned, card.ability.extra.dollars_required)
    end
}

local gumshoos = {
    name = "gumshoos", 
    pos = {x = 13, y = 0}, 
    config = {extra = {money_mod = 4, target_rank = "Ace", target_suit = "Spades", target_id = 14, targets = 3}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.targets, center.ability.extra.target_rank .. " of " .. center.ability.extra.target_suit,
            center.ability.extra.money_mod}}
    end,
    rarity = 2, 
    cost = 8, 
    stage = "One", 
    ptype = "Colorless",
    set_sprites = function(self, card, front)
        card.config.center.atlas = "poke_Pokedex7"
        card.children.center.atlas = G.ASSET_ATLAS['poke_Pokedex7']
        card.children.center:reset()
    end,
    blueprint_compat = true,
    add_to_deck = function(self, card, from_debuff)
        reset_gumshoos_card(card)
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            reset_gumshoos_card(card)
            --print(card)
        end
        if context.cardarea == G.jokers and context.scoring_hand then
            if context.joker_main and next(context.poker_hands['Flush']) then
                --for i = 1, #G.deck.cards do
                local movable_cards = {}
                for _, deckcard in ipairs(G.deck.cards) do
                    if  (deckcard:get_id() == card.ability.extra.target_id) and 
                    (deckcard:is_suit(card.ability.extra.target_suit)) then
                        --G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        table.insert(movable_cards, #movable_cards + 1, deckcard)
                    end
                end
                for i = 1, math.min(card.ability.extra.targets, #movable_cards) do
                    local copy = copy_card(movable_cards[i], nil, nil, G.playing_card)
                    copy:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, copy)
                    G.hand:emplace(copy)
                    copy.states.visible = nil
                    
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            copy:start_materialize()
                            return true
                        end
                    })) 
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function() 
                            if movable_cards[i].ability.name == 'Glass Card' then 
                                movable_cards[i]:shatter()
                            else
                                movable_cards[i]:start_dissolve()
                            end
                            return true end }))
                end
                if #movable_cards > 0 then
                    return {
                        -- message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}}, 
                        message = "Flushed out!",
                        colour = G.C.MULT,
                    }
                end
                return true
            end
        end
        if context.individual and context.cardarea == G.play then
            --Maybe it works even if the card is debuffed...
            --if (not context.other_card.debuff) and
            if  (context.other_card:get_id() == card.ability.extra.target_id) and 
            (context.other_card:is_suit(card.ability.extra.target_suit)) then
                local earned = ease_poke_dollars(card, "gumshoos", card.ability.extra.money_mod)
                return {
                    message = localize('$')..earned,
                    colour = G.C.MONEY,
                    card = card
                }
            end
        end
    end,
}

local toxtricity = {
    name = "toxtricity", 
    pos = {x = 13, y = 0}, 
    config = {extra = {}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {}}
    end,
    rarity = 2, 
    cost = 8, 
    stage = "One", 
    ptype = "Lightning",
    set_sprites = function(self, card, front)
        card.config.center.atlas = "poke_Pokedex6"
        card.children.center.atlas = G.ASSET_ATLAS['poke_Pokedex6']
        card.children.center:reset()
    end,
    blueprint_compat = true,
    calculate = function(self, card, context)
        --relevant code is in lovely/toxtricity.toml
    end,
}

local chatot = {
    name = "chatot", 
    pos = {x = 12, y = 3}, 
    config = {extra = {chips = 0, chip_mod = 0.5}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.chips, center.ability.extra.chip_mod}}
    end,
    rarity = 2,
    cost = 6,
    stage = "Basic",
    ptype = "Colorless",
    set_sprites = function(self, card, front)
        card.config.center.atlas = "poke_Pokedex4"
        card.children.center.atlas = G.ASSET_ATLAS['poke_Pokedex4']
        card.children.center:reset()
    end,
    blueprint_compat = false,
    chatter_boost = function(self, card)
        --called by
        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
        --should be silent
        --card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.BLUE})
        
        return true
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand then
            if context.joker_main then
              return {
                message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}}, 
                colour = G.C.CHIPS,
                chip_mod = card.ability.extra.chips
              }
            end
        end
    end,
}

return {name = "Pokemon Jokers 541-570", 
        list = {trubbish, garbodor, timburr, gurdurr, conkeldurr, alolan_grimer, alolan_muk, yungoos, gumshoos, toxtricity, chatot},
}

-- local kakuna={
--     name = "kakuna", 
--     pos = {x = 0, y = 1}, 
--     config = {extra = {chips = 32, rounds = 3}},
--     loc_vars = function(self, info_queue, center)
--       type_tooltip(self, info_queue, center)
--           return {vars = {center.ability.extra.chips, center.ability.extra.rounds}}
--     end,
--     rarity = 1, 
--     cost = 4, 
--     stage = "One", 
--     atlas = "Pokedex1",
--     ptype = "Grass",
--     blueprint_compat = true,
--     calculate = function(self, card, context)
--       if context.cardarea == G.jokers and context.scoring_hand then
--         if context.joker_main then
--           return {
--               message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}}, 
--               colour = G.C.CHIPS,
--               chip_mod = card.ability.extra.chips
--             }
--         end
--       end
--       return level_evo(self, card, context, "j_poke_beedrill")
--     end,
--   }

-- local starmie={
--     name = "starmie", 
--     pos = {x = 3, y = 9},
--     config = {extra = {mult = 4, money_mod = 1, suit = "Diamonds"}},
--     loc_vars = function(self, info_queue, center)
--       type_tooltip(self, info_queue, center)
--       return {vars = {center.ability.extra.mult, center.ability.extra.money_mod, localize(center.ability.extra.suit, 'suits_singular')}}
--     end,
--     rarity = "poke_safari", 
--     cost = 10, 
--     stage = "One", 
--     ptype = "Water",
--     atlas = "Pokedex1",
--     blueprint_compat = true,
--     calculate = function(self, card, context)
--       if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
--         if not context.end_of_round and not context.before and not context.after and not context.other_card.debuff then
--           local earned = ease_poke_dollars(card, "starmie", card.ability.extra.money_mod, true)
--           return {
--             mult = card.ability.extra.mult,
--             dollars = earned,
--             card = card
--           }
--         end
--       end
--     end
--   }