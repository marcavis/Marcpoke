local chikorita={ 
    name = "chikorita",
    pos = {x = 0, y = 0},
    config = {extra = {money_mod = 1, earned = 0, d_size = -1, h_size = 1, dollars_required = 12}},
    loc_vars = function(self, info_queue, center)
      type_tooltip(self, info_queue, center)
          return {vars = {center.ability.extra.money_mod, center.ability.extra.earned, center.ability.extra.d_size, center.ability.extra.h_size, center.ability.extra.dollars_required}}
    end,
    rarity = 2, 
    cost = 5, 
    stage = "Basic",
    ptype = "Grass",
    atlas = "marcPoke2",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.pre_discard and not context.hook then
            local earned = 0
            if not context.blueprint then
                card.ability.extra.earned = card.ability.extra.earned + card.ability.extra.money_mod
            end
            earned = earned + card.ability.extra.money_mod
            earned = ease_poke_dollars(card, "chiko", earned)
            return {
                message = localize('$')..earned,
                colour = G.C.MONEY,
                card = card
            }
        end
        return scaling_evo(self, card, context, "j_marcpoke_bayleef", card.ability.extra.earned, card.ability.extra.dollars_required)
    end,
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.h_size)
        if not from_debuff then
            G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
            ease_discard(card.ability.extra.d_size)
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.h_size)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
        ease_discard(-card.ability.extra.d_size)
    end
}

local bayleef={ 
    name = "bayleef",
    pos = {x = 1, y = 0},
    config = {extra = {money_mod = 2, earned = 0, d_size = -1, h_size = 1, dollars_required = 24}},
    loc_vars = function(self, info_queue, center)
      type_tooltip(self, info_queue, center)
      return {vars = {center.ability.extra.money_mod, center.ability.extra.earned, center.ability.extra.d_size, center.ability.extra.h_size, center.ability.extra.dollars_required}}
    end,
    rarity = "poke_safari", 
    cost = 9, 
    stage = "One",
    ptype = "Grass",
    atlas = "marcPoke2",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.pre_discard and not context.hook then
            local earned = 0
            if not context.blueprint then
                card.ability.extra.earned = card.ability.extra.earned + card.ability.extra.money_mod
            end
            earned = earned + card.ability.extra.money_mod
            earned = ease_poke_dollars(card, "bay", earned)
            return {
                message = localize('$')..earned,
                colour = G.C.MONEY,
                card = card
            }
        end
        return scaling_evo(self, card, context, "j_marcpoke_meganium", card.ability.extra.earned, card.ability.extra.dollars_required)
    end,
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.h_size)
        if not from_debuff then
            G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
            ease_discard(card.ability.extra.d_size)
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.h_size)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
        ease_discard(-card.ability.extra.d_size)
    end
}

local meganium={ 
    name = "meganium",
    pos = {x = 2, y = 0},
    config = {extra = {money_mod = 3, earned = 0, h_size = 1}},
    loc_vars = function(self, info_queue, center)
      type_tooltip(self, info_queue, center)
      return {vars = {center.ability.extra.money_mod, center.ability.extra.earned, center.ability.extra.h_size}}
    end,
    rarity = "poke_safari", 
    cost = 10, 
    stage = "Two",
    ptype = "Grass",
    atlas = "marcPoke2",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.pre_discard and not context.hook then
            local earned = 0
            earned = ease_poke_dollars(card, "mega", card.ability.extra.money_mod)
            return {
                message = localize('$')..earned,
                colour = G.C.MONEY,
                card = card
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.h_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.h_size)
    end
}




return {name = "Eryn's Pokemon", 
        --list = {chikorita, bayleef, meganium},
        list = {},
}