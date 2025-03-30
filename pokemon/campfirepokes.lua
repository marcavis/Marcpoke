local surskit={ 
    name = "surskit",
    pos = {x = 1, y = 3},
    config = {extra = {money_mod = 1, earned = 0, d_size = -1, h_size = 1, dollars_required = 12}},
    loc_vars = function(self, info_queue, center)
      type_tooltip(self, info_queue, center)
          return {vars = {center.ability.extra.money_mod, center.ability.extra.earned, center.ability.extra.d_size, center.ability.extra.h_size, center.ability.extra.dollars_required}}
    end,
    rarity = 2, 
    cost = 5, 
    stage = "Basic",
    ptype = "Water",
    atlas = "marcPoke3",
    blueprint_compat = true,
    calculate = function(self, card, context)
        --return scaling_evo(self, card, context, "j_marcpoke_bayleef", card.ability.extra.earned, card.ability.extra.dollars_required)
    end,
}

local masquerain={ 
    name = "masquerain",
    pos = {x = 2, y = 3},
    config = {extra = {money_mod = 2, earned = 0, d_size = -1, h_size = 1, dollars_required = 24}},
    loc_vars = function(self, info_queue, center)
      type_tooltip(self, info_queue, center)
      return {vars = {center.ability.extra.money_mod, center.ability.extra.earned, center.ability.extra.d_size, center.ability.extra.h_size, center.ability.extra.dollars_required}}
    end,
    rarity = "poke_safari", 
    cost = 9, 
    stage = "One",
    ptype = "Water",
    atlas = "marcPoke3",
    blueprint_compat = true,
    calculate = function(self, card, context)

    end,

}

local test_magmar={
    name = "test_magmar", 
    pos = {x = 8, y = 9}, 
    config = {extra = {mult = 0, mult_mod = 3}},
    loc_vars = function(self, info_queue, center)
      type_tooltip(self, info_queue, center)
      info_queue[#info_queue+1] = G.P_CENTERS.c_poke_linkcable
      return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod}}
    end,
    rarity = 3, 
    cost = 7, 
    item_req = "linkcable",
    stage = "Basic", 
    ptype = "Fire",
    atlas = "marcPoke1",
    blueprint_compat = false,
    calculate = function(self, card, context)
      if context.first_hand_drawn and not context.blueprint then
        card.ability.extra.remove_triggered = false
        local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES and not card.ability.extra.remove_triggered end
        juice_card_until(card, eval, true)
      end
      if context.discard and not context.blueprint then
        if is_first_discard() and context.full_hand and #context.full_hand == 1 and not card.ability.extra.remove_triggered then
          if #SMODS.find_card("j_marcpoke_masquerain") == 0 then
            card.ability.extra.remove_triggered = true
          end
          card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize("k_upgrade_ex")})
          return {
            remove = true
          }
        end
      end
      if context.cardarea == G.jokers and context.scoring_hand then
        if context.joker_main then
          return {
            message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
            colour = G.C.MULT,
            mult_mod = card.ability.extra.mult
          }
        end
      end
      return item_evo(self, card, context, "j_poke_magmortar")
    end
  }


is_first_discard = function()
    return G.GAME.current_round.discards_used == 0 or (#SMODS.find_card("j_marcpoke_masquerain") > 0)
end

return {name = "Campfire's Pokemon", 
  list = {}
        -- list = {surskit, masquerain, test_magmar},
}