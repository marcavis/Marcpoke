local sigilyph = {
    name = "sigilyph", 
    pos = {x = 11, y = 4}, 
    config = { extra = {
        efficiency = 0.25, chip_total = 0, mult_total = 0, Xmult_total = 1, dollars_total = 0
    }},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {}}
    end,
    rarity = "poke_safari", 
    cost = 8,
    ptype = "Psychic",
    stage = "Basic", 
    atlas = "marcPoke5",
    aux_poke = true,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand and context.modify_scoring_values then
            -- print (context.scoring_hand)
            local bonuschips = 0
            local bonusmult = 0
            for name, hand in pairs(context.poker_hands) do
                if next(hand) and name ~= "top" then 
                    -- print(name); print(G.GAME.hands[name].chips, G.GAME.hands[name].mult)m
                    bonuschips = bonuschips + G.GAME.hands[name].chips
                    bonusmult = bonusmult + G.GAME.hands[name].mult
                end
            end
            -- print(bonuschips)
            return {
                message = "Mystery!",
                colour = G.C.BLACK,
                mult_mod = bonusmult,
                chip_mod = bonuschips,
              }
            -- print(inspect(context.poker_hands))
            -- print(context.poker_hands['Pair'])m
            -- print(next(context.poker_hands.top))
        end
    end
}


return {
    name = "Marcpoke Jokers", 
    -- list = {sigilyph},
    list = {}
}
