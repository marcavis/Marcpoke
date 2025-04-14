local shuppet = {
    name = "shuppet",
    pos = {x = 4, y = 10}, 
    config = {extra = {chips = 0, chip_mod = 15, rounds = 5}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.chips, center.ability.extra.chip_mod, center.ability.extra.rounds}}
    end,
    rarity = 2, 
    cost = 4,
    ptype = "Psychic",
    stage = "Basic", 
    atlas = "marcPoke3",
    blueprint_compat = true,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand then
            if context.joker_main then
                if card.ability.extra.chips > 0 then
                    return {
                        message = "...",
                        colour = G.C.BLACK,
                        chip_mod = card.ability.extra.chips,
                    }
                end
            end
        end
        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            local dolls = 0; local disabled = 0
            for i, v in ipairs(G.jokers.cards) do
                if v.config.center.is_doll then dolls = dolls + 1 end
                if v.debuff then disabled = disabled + 1 end
            end
            card.ability.extra.chips = card.ability.extra.chips + (card.ability.extra.chip_mod * (dolls + disabled))
            if (dolls + disabled) > 0 then
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("k_upgrade_ex")})
            end
        end
        return level_evo(self, card, context, "j_marcpoke_banette")
    end,
}

local banette = {
    name = "banette",
    pos = {x = 5, y = 10}, 
    config = {extra = {chips = 0, Xmult = 1, chip_mod = 15, Xmult_mod = 0.08}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.chips, center.ability.extra.Xmult, center.ability.extra.chip_mod, center.ability.extra.Xmult_mod}}
    end,
    rarity = "poke_safari", 
    cost = 8,
    ptype = "Psychic",
    stage = "One", 
    atlas = "marcPoke3",
    blueprint_compat = true,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand then
            if context.joker_main then
                if card.ability.extra.chips > 0 or card.ability.extra.Xmult > 1 then
                    return {
                    message = "...",
                    colour = G.C.BLACK,
                    chip_mod = card.ability.extra.chips,
                    Xmult_mod = card.ability.extra.Xmult
                    }
                end
            end
        end
        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            local dolls = 0; local disabled = 0
            for i, v in ipairs(G.jokers.cards) do
                if v.config.center.is_doll then dolls = dolls + 1 end
                if v.debuff then disabled = disabled + 1 end
            end
            card.ability.extra.chips = card.ability.extra.chips + (card.ability.extra.chip_mod * (dolls + disabled))
            card.ability.extra.Xmult = card.ability.extra.Xmult + (card.ability.extra.Xmult_mod * (dolls + disabled))
            if (dolls + disabled) > 0 then
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("k_upgrade_ex")})
            end
        end
    end,
}

return {name = "Marcpoke Jokers", 
        list = {shuppet, banette},
}
