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
return {name = "Pokemon Jokers 541-570", 
        list = {trubbish, garbodor},
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