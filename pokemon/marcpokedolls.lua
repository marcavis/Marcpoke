local snorlax_doll = {
    name = "snorlax_doll", 
    pos = {x = 0, y = 11}, 
    config = {extra = {Xmult_mod = 0.2, Xmult = 1}},
    loc_vars = function(self, info_queue, center)
        return {vars = {}}
    end,
    is_doll = true,
    rarity = "poke_safari",
    cost = 6,
    stage = "Other",
    atlas = "marcPoke1",
    aux_poke = true,
    blueprint_compat = false,
    calculate = function(self, card, context)
        --if SMODS.find_card("j_marcpoke_shuppet") or SMODS.find_card("j_marcpoke_banette") then
        if context.cardarea == G.jokers and context.scoring_hand then
            if context.joker_main then
                if has_poke_adjacent(card, "j_marcpoke_shuppet") or #SMODS.find_card("j_marcpoke_banette") > 0 then
                    return {
                    message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}}, 
                    colour = G.C.XMULT,
                    Xmult_mod = card.ability.extra.Xmult
                    }
                end
            end
        elseif not context.repetition and not context.individual and context.end_of_round and not context.blueprint then
            if has_poke_adjacent(card, "j_marcpoke_shuppet") or #SMODS.find_card("j_marcpoke_banette") > 0 then
                local count = find_joker('leftovers')
                if #count > 0 then
                    card.ability.extra.Xmult = card.ability.extra.Xmult + (card.ability.extra.Xmult_mod * #count)
                    return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.RED
                    }
                end
            end
        end
    end
}

local clefairy_doll = {
    name = "clefairy_doll", 
    pos = {x = 8, y = 2}, 
    config = {extra = {mult = 2, suit = "Clubs"}},
    loc_vars = function(self, info_queue, center)
        return {vars = {}}
    end,
    is_doll = true,
    rarity = "poke_safari",
    cost = 6,
    stage = "Other",
    atlas = "marcPoke1",
    aux_poke = true,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
            if not context.end_of_round and not context.before and not context.after and not context.other_card.debuff then
                if has_poke_adjacent(card, "j_marcpoke_shuppet") or #SMODS.find_card("j_marcpoke_banette") > 0 then
                    return {
                        mult = card.ability.extra.mult,
                        card = card
                    }
                end
            end
        end
    end,
}

return {name = "Pokemon Jokers 541-570", 
        list = {snorlax_doll, clefairy_doll},
}
