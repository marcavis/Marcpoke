
local scraggy = {
    name = "scraggy",
    pos = {x = 9, y = 4}, 
    config = {extra = {efficiency = 0.15, rounds = 4, chip_total = 0, mult_total = 0, Xmult_total = 1, dollars_total = 0}},
    loc_vars = function(self, info_queue, center)
        center.config.center:update_bonuses(center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.efficiency * 100,
                        center.ability.extra.chip_total,
                        center.ability.extra.mult_total,
                        center.ability.extra.Xmult_total,
                        center.ability.extra.dollars_total,
                        center.ability.extra.rounds}}
    end,
    rarity = 2, 
    cost = 4,
    ptype = "Dark",
    stage = "Basic", 
    atlas = "marcPoke5",
    blueprint_compat = true,
    update_bonuses = function(self, center)
        if not G.jokers or not G.jokers.cards then return nil end
        center.ability.extra.chip_total = 0
        center.ability.extra.mult_total = 0
        center.ability.extra.Xmult_total = 1
        center.ability.extra.dollars_total = 0
        for k, v in pairs(G.jokers.cards) do
            if v.ability and v.ability.extra and type(v.ability.extra) == "table" then
                if v.ability.extra.chips then
                    center.ability.extra.chip_total = center.ability.extra.chip_total + (v.ability.extra.chips * center.ability.extra.efficiency)
                end
                if v.ability.extra.mult then
                    center.ability.extra.mult_total = center.ability.extra.mult_total + (v.ability.extra.mult * center.ability.extra.efficiency)
                end
                if v.ability.extra.Xmult and v.ability.extra.Xmult >= 1 then
                    center.ability.extra.Xmult_total = center.ability.extra.Xmult_total + ((v.ability.extra.Xmult - 1) * center.ability.extra.efficiency)
                end
                if v.ability.extra.money then
                    center.ability.extra.dollars_total = center.ability.extra.dollars_total + (v.ability.extra.money * center.ability.extra.efficiency)
                end
            end
        end
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand then
            if context.joker_main then
                card.config.center:update_bonuses(card)
                return {
                  message = "Beat Up!",
                  colour = G.C.BLACK,
                  mult_mod = card.ability.extra.mult_total,
                  chip_mod = card.ability.extra.chip_total,
                  Xmult_mod = card.ability.extra.Xmult_total
                }
            end
        end
        if G.jokers and G.jokers.config.card_count >= G.jokers.config.card_limit then
            return level_evo(self, card, context, "j_marcpoke_scrafty")
        end
    end,
    calc_dollar_bonus = function(self, card)
        card.config.center:update_bonuses(card)
        if card.ability.extra.dollars_total > 0 then
            return ease_poke_dollars(card, "Scraggy", card.ability.extra.dollars_total, true)
        end
    end
    }

local scrafty = {
    name = "scrafty",
    pos = {x = 10, y = 4}, 
    config = {extra = {efficiency = 0.25, chip_total = 0, mult_total = 0, Xmult_total = 1, dollars_total = 0}},
    loc_vars = function(self, info_queue, center)
        center.config.center:update_bonuses(center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.efficiency * 100,
                        center.ability.extra.chip_total,
                        center.ability.extra.mult_total,
                        center.ability.extra.Xmult_total,
                        center.ability.extra.dollars_total}}
    end,
    rarity = "poke_safari", 
    cost = 8,
    ptype = "Dark",
    stage = "One", 
    atlas = "marcPoke5",
    blueprint_compat = true,
    update_bonuses = function(self, center)
        if not G.jokers or not G.jokers.cards then return nil end
        center.ability.extra.chip_total = 0
        center.ability.extra.mult_total = 0
        center.ability.extra.Xmult_total = 1
        center.ability.extra.dollars_total = 0
        for k, v in pairs(G.jokers.cards) do
            if v.ability and v.ability.extra and type(v.ability.extra) == "table" then
                if v.ability.extra.chips then
                    center.ability.extra.chip_total = center.ability.extra.chip_total + (v.ability.extra.chips * center.ability.extra.efficiency)
                end
                if v.ability.extra.mult then
                    center.ability.extra.mult_total = center.ability.extra.mult_total + (v.ability.extra.mult * center.ability.extra.efficiency)
                end
                if v.ability.extra.Xmult and v.ability.extra.Xmult >= 1 then
                    center.ability.extra.Xmult_total = center.ability.extra.Xmult_total + ((v.ability.extra.Xmult - 1) * center.ability.extra.efficiency)
                end
                if v.ability.extra.money then
                    center.ability.extra.dollars_total = center.ability.extra.dollars_total + (v.ability.extra.money * center.ability.extra.efficiency)
                end
            end
        end
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand then
            if context.joker_main then
                card.config.center:update_bonuses(card)
                return {
                  message = "Beat Up!",
                  colour = G.C.BLACK,
                  mult_mod = card.ability.extra.mult_total,
                  chip_mod = card.ability.extra.chip_total,
                  Xmult_mod = card.ability.extra.Xmult_total
                }
            end
        end
    end,
    calc_dollar_bonus = function(self, card)
        card.config.center:update_bonuses(card)
        if card.ability.extra.dollars_total > 0 then
            return ease_poke_dollars(card, "Scrafty", card.ability.extra.dollars_total, true)
        end
    end
  }

local trubbish = {
    name = "trubbish",
    poke_custom_prefix = "marcpoke",
    pos = {x = 4, y = 5}, 
    config = {extra = {chips = 10, rounds = 5}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.chips,
                        center.ability.extra.rounds,
                        (center.ability.extra.chips/100) * center.config.center:sumchips()}}
    end,
    rarity = 2, 
    cost = 4,
    ptype = "Dark",
    stage = "Basic", 
    atlas = "marcPoke5",
    blueprint_compat = true,
    sumchips = function(self)
        if not G.deck then return 0 end
        local chipSum = 0
        for k, v in pairs(G.deck.cards) do
            local total_chips = poke_total_chips(v)
            chipSum = chipSum + total_chips
        end
        return chipSum
    end,
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
    pos = {x = 5, y = 5}, 
    config = {extra = {chips = 25}},
    loc_vars = function(self, info_queue, center)
      type_tooltip(self, info_queue, center)
      return {vars = {center.ability.extra.chips, (center.ability.extra.chips/100) * center.config.center:sumchips()}}
    end,
    rarity = "poke_safari", 
    cost = 8,
    ptype = "Dark",
    stage = "One", 
    atlas = "marcPoke5",
    blueprint_compat = true,
    sumchips = function(self)
        if not G.deck then return 0 end
        local chipSum = 0
        for k, v in pairs(G.deck.cards) do
            local total_chips = poke_total_chips(v)
            chipSum = chipSum + total_chips
        end
        return chipSum
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand then
            if context.joker_main and #G.deck.cards > 0 then
                local chipSum = card.config.center:sumchips()
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
    atlas = "marcPoke5",
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
    atlas = "marcPoke5",
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
    atlas = "marcPoke5",
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
    pos = {x = 2, y = 1}, 
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
    atlas = "regionals",
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
    pos = {x = 3, y = 1}, 
    config = {extra = {mult = 10, mult_mod = 2, targets = 2, minimum_deck_size = 20}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.targets,
        center.ability.extra.mult, center.ability.extra.mult_mod, center.ability.extra.minimum_deck_size}}
    end,
    rarity = 3, 
    cost = 8, 
    stage = "One", 
    ptype = "Dark",
    atlas = "regionals",
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
    
    config = {extra = {money = 4, target_rank = "Ace", target_suit = "Spades", target_id = 14, earned = 0, dollars_required = 8}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.target_rank .. " of " .. center.ability.extra.target_suit,
                center.ability.extra.money, center.ability.extra.earned, center.ability.extra.dollars_required}}
    end,
    rarity = 1, 
    cost = 4, 
    stage = "One", 
    ptype = "Colorless",
    atlas = "marcPoke7",
    blueprint_compat = true,
    add_to_deck = function(self, card, from_debuff)
        reset_gumshoos_card(card)
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            reset_gumshoos_card(card)
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize(card.ability.extra.target_rank or "2", 'ranks').."s of "..localize(card.ability.extra.target_suit, 'suits_plural')})
        end
        if context.individual and context.cardarea == G.play then
            --Maybe it works even if the card is debuffed...
            --if (not context.other_card.debuff) and
            if  (context.other_card:get_id() == card.ability.extra.target_id) and 
            (context.other_card:is_suit(card.ability.extra.target_suit)) then
                local earned = 0
                if not context.blueprint then
                    card.ability.extra.earned = card.ability.extra.earned + card.ability.extra.money
                end
                earned = earned + card.ability.extra.money
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
    config = {extra = {money = 4, target_rank = "Ace", target_suit = "Spades", target_id = 14, targets = 3}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.targets, center.ability.extra.target_rank .. " of " .. center.ability.extra.target_suit,
            center.ability.extra.money}}
    end,
    rarity = 2, 
    cost = 8, 
    stage = "One", 
    ptype = "Colorless",
    atlas = "marcPoke7",
    blueprint_compat = true,
    add_to_deck = function(self, card, from_debuff)
        reset_gumshoos_card(card)
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            reset_gumshoos_card(card)
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize(card.ability.extra.target_rank or "2", 'ranks').."s of "..localize(card.ability.extra.target_suit, 'suits_plural')})
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
                local earned = ease_poke_dollars(card, "gumshoos", card.ability.extra.money)
                return {
                    message = localize('$')..earned,
                    colour = G.C.MONEY,
                    card = card
                }
            end
        end
    end,
}

local toxtricity_amped = {
    name = "toxtricity_amped", 
    pos = {x = 13, y = 2}, 
    config = {extra = {}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {}}
    end,
    rarity = 2, 
    cost = 8, 
    stage = "One", 
    ptype = "Lightning",
    atlas = "marcPoke8",
    blueprint_compat = true,
    calculate = function(self, card, context)
        --relevant code is in lovely/toxtricity.toml
    end,
}

local toxtricity_lowkey = {
    name = "toxtricity_lowkey", 
    pos = {x = 0, y = 3}, 
    config = {extra = {}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {}}
    end,
    rarity = 2, 
    cost = 8, 
    stage = "One", 
    ptype = "Lightning",
    atlas = "marcPoke8",
    blueprint_compat = true,
    --joker_destroyed_effect = function(self, card)
    disabled_joker_destroyed_effect = function(self, card)
        local forced_key = matching_energy(card);
        local _card = create_card('Energy', G.consumeables, nil, nil, nil, nil, forced_key)
        local edition = {negative = true}
        _card:set_edition(edition, true)
        _card:add_to_deck()
        G.consumeables:emplace(_card)
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("poke_plus_energy"), colour = G.ARGS.LOC_COLOURS["pink"]})
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            if context.blind == G.P_BLINDS.bl_small then
                local forced_key = matching_energy(card);
                local _card = create_card('Energy', G.consumeables, nil, nil, nil, nil, forced_key)
                local edition = {negative = true}
                _card:set_edition(edition, true)
                _card:add_to_deck()
                G.consumeables:emplace(_card)
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("poke_plus_energy"), colour = G.ARGS.LOC_COLOURS["pink"]})
            end
        end
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
    atlas = "marcPoke4",
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

local maractus = {
    name = "maractus", 
    pos = {x = 6, y = 4}, 
    config = {extra = {mult_mod = 7, money_mod = 7}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.mult_mod, center.ability.extra.money_mod}}
    end,
    rarity = 2,
    cost = 6,
    enhancement_gate = 'm_lucky',
    stage = "Basic",
    ptype = "Grass",
    atlas = "marcPoke5",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card and context.other_card.lucky_trigger then
            context.other_card.ability.p_dollars = context.other_card.ability.p_dollars + card.ability.extra.money_mod
            context.other_card.ability.mult = context.other_card.ability.mult + card.ability.extra.mult_mod
            return {
                extra = {message = localize('k_upgrade_ex'), colour = G.C.CHIPS},
                colour = G.C.MONEY,
                card = card
            }
        end
    end,
}

local cinderace = {
    name = "cinderace",
    pos = {x = 5, y = 0},
    config = {extra = {mult = 0, ball_effect = 1.0, Xmult_mod = 0.2}, nines = 0, tens = 0, default_ball_effect = 1.0},
    
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.ball_effect, center.ability.extra.mult}}
    end,
    rarity = "poke_safari",
    stage = "Two",
    ptype = "Fire",
    atlas = "marcPoke8",
    blueprint_compat = true,
    add_to_deck = function(self, card, from_debuff)
        card.ability.soccer_sticker = true
    end,
    calculate = function(self, card, context)
        -- if context.individual and context.cardarea == G.play then
        --     if context.other_card:get_id() == 10 or context.other_card:get_id() == 10 then

        --     end
        -- end
        if context.cardarea == G.jokers and context.full_hand then
            if context.before and not context.blueprint then
                --card.ability.ninesrequired = #context.scoring_hand
                card.ability.nines = 0
                card.ability.tens = 0
                card.ability.aces = 0
                for k, v in pairs(context.full_hand) do
                    if v:get_id() == 10 then --power up the ball
                        card.ability.tens = card.ability.tens + 1
                    elseif v:get_id() == 14 then
                        card.ability.aces = card.ability.aces + 1
                    elseif v:get_id() == 9 then --use up the ball sticker, getting a reward now and losing it for this round
                        card.ability.nines = card.ability.nines + 1
                    end
                end
                
                if card.ability.soccer_sticker then
                    print(card.ability.extra.ball_effect)
                    card.ability.extra.ball_effect = card.ability.extra.ball_effect + (2 * card.ability.extra.Xmult_mod * card.ability.tens)
                    print(card.ability.extra.ball_effect)
                    card.ability.extra.ball_effect = card.ability.extra.ball_effect * math.pow(1.0 + card.ability.extra.Xmult_mod, card.ability.aces)
                    print(card.ability.extra.ball_effect)
                    return {
                        message = "Power up!",
                        colour = G.C.MULT
                    }
                end
            elseif context.joker_main then
                if card.ability.soccer_sticker and card.ability.nines > 0 then
                    card.ability.soccer_sticker = false
                    card.ability.extra.ball_effect = card.ability.extra.ball_effect + (card.ability.extra.Xmult_mod * card.ability.nines)
                    print(card.ability.extra.ball_effect)
                    local message_flavor
                    if card.ability.nines > 3 then message_flavor = "Great Goal!!!" end
                    return {
                        message = message_flavor or "Goal!", 
                        colour = G.C.MULT,
                        Xmult_mod = card.ability.extra.ball_effect,
                        mult_mod = card.ability.extra.mult,
                    }
                end
                return {
                    message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
                    colour = G.C.MULT,
                    mult_mod = card.ability.extra.mult
                }
            end
        end
        if not context.repetition and not context.individual and context.end_of_round and not context.blueprint then
            card.ability.extra.ball_effect = card.ability.default_ball_effect
            --restore the ball sticker to Cinderace
            card.ability.soccer_sticker = true
            return {
                message = localize('k_reset'),
                colour = G.C.RED
            }
        end
    end,
}

return {name = "Pokemon Jokers 541-570", 
        list = {scraggy, scrafty, trubbish, garbodor, timburr, gurdurr, conkeldurr, alolan_grimer, alolan_muk, yungoos, gumshoos, toxtricity_amped, toxtricity_lowkey, chatot, maractus, cinderace},
}
