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


local sinistea = {
    name = "sinistea", 
    pos = {x = 5, y = 3},
    config = {extra = {}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        if G.consumeables and #G.consumeables.cards > 0 then
            local item_key = G.consumeables.cards[1].config.center.key
            local item_name = G.consumeables.cards[1].ability.name
            local item_set = G.consumeables.cards[1].ability.set
            local sinistea_return = consumable_trigger_effect(G.consumeables.cards[1], center, nil)
            if item_set == "Planet" then
                info_queue[#info_queue+1] = {
                    set = "Other", key = "haunted_planet",
                    vars = {"Sinistea", item_name, sinistea_return.chip_mod, sinistea_return.mult_mod}}
            else
                if sinistea_return.itworks or sinistea_return.Xmult_mod or sinistea_return.mult_mod
                or sinistea_return.chip_mod or sinistea_return.dollars or sinistea_return.repetitions then
                    info_queue[#info_queue+1] = {
                        set = "Other", key = "haunted_" .. item_key,
                        vars = {"Sinistea", item_name, G.GAME.probabilities.normal, sinistea_return.odds or 1}}
                else
                    info_queue[#info_queue+1] = {
                        set = "Other", key = "haunted_strange", 
                        vars = {"Sinistea", item_name, G.GAME.probabilities.normal, sinistea_return.odds or 1}}
                end
            end
        end
        local alt_key = nil
        if center.ability.extra.form == 1 then
            alt_key = "j_marcpoke_sinistea2"
            -- info_queue[#info_queue+1] = {key = 'tag_coupon', set = 'Tag'}
            -- info_queue[#info_queue+1] = {set = 'Other', key = 'holding', vars = {"Coupon Tag"}}
        end
        local effect = "Nothing"
        return {vars = {effect}, key = alt_key}
    end,
    rarity = 2,
    cost = 6,
    stage = "Basic",
    ptype = "Psychic",
    atlas = "marcPoke8",
    blueprint_compat = true,
    set_ability = function(self, card, initial, delay_sprites)
        if initial then
            if pseudorandom('sinistea') < (1/4) then
                card.ability.extra.form = 1
                --self:set_sprites(card)
            end
        end
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local sinistea_return = consumable_trigger_effect(G.consumeables.cards[1], card, context)
            if sinistea_return.repetitions then return sinistea_return end
            -- if (context.other_card == context.scoring_hand[1]) or (context.other_card == context.scoring_hand[2]) then
            --   return {
            --       message = localize('k_again_ex'),
            --       repetitions = card.ability.extra.retriggers,
            --       card = card
            --   }
            -- end
        end
        if context.other_consumeable and context.other_consumeable.rank == 1 then
            local item_set = context.other_consumeable.ability.set
            local sinistea_return = consumable_trigger_effect(context.other_consumeable, card, context)
            sinistea_return.colour = G.C.MULT
            sinistea_return.message = context.other_consumeable.ability.name.."!"
            --let's ignore money rewards at this time
            sinistea_return.dollars = nil
            --print(sinistea_return)
            --print(sinistea_return)
            if sinistea_return.afterwards then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = sinistea_return.afterwards(context.other_consumeable, card)
                }))
            end
            if sinistea_return.chip_mod or sinistea_return.mult_mod or sinistea_return.Xmult_mod then 
                return sinistea_return
            end
            -- print(sinistea_return)
            -- if sinistea_return.afterwards then
            --     print("killing something")
            --     sinistea_return.afterwards(context.other_consumeable, card)
            -- end
            -- if context.other_consumeable.ability.name == "twisted_spoon" then
            --   Xmult = card.ability.extra.Xmult_multi2
            -- else
            --   Xmult = card.ability.extra.Xmult_multi
            -- end
            -- return {
            --   message = localize{type = 'variable', key = 'a_xmult', vars = {Xmult}}, 
            --   colour = G.C.XMULT,
            --   Xmult_mod = Xmult
            -- }
        end
    end,
    calc_dollar_bonus = function(self, card)
        local item_set = G.consumeables.cards[1].ability.set
        local sinistea_return = consumable_trigger_effect(G.consumeables.cards[1], card, nil)
        if sinistea_return.dollars then
            return ease_poke_dollars(card, "", sinistea_return.dollars, true)
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        if card.ability.extra.form == 1 then
            if not from_debuff then
                card.ability.extra_value = card.ability.extra_value + 4
                card:set_cost()
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Genuine Article!"})
            end
        end
    end,
    update = function(self, card, dt)

    end
    --   add_to_deck = function(self, card, from_debuff)
    --     G.E_MANAGER:add_event(Event({func = function()
    --       G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.card_limit
    --       return true end }))
    --   end,
    --   remove_from_deck = function(self, card, from_debuff)
    --     G.E_MANAGER:add_event(Event({func = function()
    --       G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.card_limit
    --       return true end }))
    --   end, 
}


consumable_trigger_effect = function (item, card, context)
    local econ_reward = 3
    local set = item.ability.set
    local name = item.ability.name

    if set == "Planet" then
        return {
            mult_mod = G.GAME.hands[item.ability.consumeable.hand_type].l_mult,
            chip_mod = G.GAME.hands[item.ability.consumeable.hand_type].l_chips
        }
    end
    if name == "The Magician" then
        local result = {}
        if pseudorandom('sinistea_mult') < G.GAME.probabilities.normal/5 then result.mult_mod = 20 end
        --if pseudorandom('sinistea_money') < G.GAME.probabilities.normal/15 then result.dollars = 3 end
        return result
    elseif name == "The Empress" then
        return {mult_mod = 8}
    elseif name == "Justice" then
        return {Xmult_mod = 2, odds = 4,
                afterwards = function(consumable, card)
                    if pseudorandom('sinistea') < G.GAME.probabilities.normal/4 then poke_remove_card(consumable, card) end
                end}
    elseif name == "The Chariot" then
        return {Xmult_mod = 1.5}
    elseif name == "Fire Stone" then
        return {mult_mod = 12}
    elseif name == "The Devil" or name == "Temperance" or name == "Talisman" then
        return { dollars = 3}
    elseif name == "The Wheel of Fortune" then
        local result = {odds = 4, chip_mod = 0, mult_mod = 0, Xmult_mod = 1}
        if pseudorandom('sinistea') < G.GAME.probabilities.normal/4 then
            local wheel_roll = pseudorandom('siniswheel')
            if wheel_roll > .5 then result.chip_mod = 50
            elseif wheel_roll < .125 then result.Xmult_mod = 1.5
            else result.mult_mod = 10 end
        end
        return result
    elseif name == "Ouija" then
        if context and next(context.poker_hands['Four of a Kind']) then
            return {Xmult_mod = 2}    
        end
        return {Xmult_mod = 1}
    elseif name == "Sigil" then
        if context and next(context.poker_hands['Flush']) then
            return {Xmult_mod = 2}    
        end
        return {Xmult_mod = 1}
    elseif name == "Deja Vu" then
        if context and context.other_card == context.scoring_hand[1] then
            return {repetitions = 1, card = card}
        end
        return {itworks = true}
    else
        return {}
    end
end

return {name = "Marcpoke Jokers", 
list = {shuppet, banette, sinistea},
}
