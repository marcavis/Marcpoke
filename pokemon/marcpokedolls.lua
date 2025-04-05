local snorlax_doll = {
    name = "snorlax_doll", 
    pos = {x = 0, y = 11}, 
    config = {extra = {}},
    loc_vars = function(self, info_queue, center)
        return {vars = {}}
    end,
    rarity = "poke_safari",
    cost = 6,
    stage = "Other",
    atlas = "marcPoke1",
    aux_poke = true,
    blueprint_compat = false,
    calculate = function(self, card, context)
        print("qqq")
        if #SMODS.find_card("j_poke_caterpie") > 0 then
            print("www")
            G.P_CENTERS.j_poke_snorlax.calculate(self, card, context)
        end
    end,
}

local clefairy_doll = {
    name = "clefairy_doll", 
    pos = {x = 8, y = 2}, 
    config = {extra = {}},
    loc_vars = function(self, info_queue, center)
        return {vars = {}}
    end,
    rarity = "poke_safari",
    cost = 6,
    stage = "Other",
    atlas = "marcPoke1",
    aux_poke = true,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if #SMODS.find_card("j_poke_caterpie") > 0 then
            G.P_CENTERS.j_poke_clefairy.calculate(self, card, context)
        end
    end,
}

return {name = "Pokemon Jokers 541-570", 
        list = {snorlax_doll, clefairy_doll},
}
