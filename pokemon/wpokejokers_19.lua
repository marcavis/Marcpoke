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
        atlas = "marcPoke5",
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
    atlas = "marcPoke5",
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
    pos = {x = 6, y = 5}, 
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
    pos = {x = 7, y = 5}, 
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
    pos = {x = 8, y = 5}, 
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

return {name = "Pokemon Jokers 541-570", 
        list = {trubbish, garbodor, timburr, gurdurr, conkeldurr},
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