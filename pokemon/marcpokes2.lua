local luminous_cave = {
    name = "luminous_cave", 
    pos = {x = 0, y = 0}, 
    config = {extra = {Xmult = 1.5, Xmult_mod = 0.3, mult_mod2 = 2}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.Xmult, center.ability.extra.Xmult_mod}}
        --dunno if I wanna use mult_mod2 after all
    end,
    rarity = 3,
    cost = 8,
    stage = "Other",
    ptype = "Colorless",
    atlas = "luminous_cave",
    blueprint_compat = true,
    evolution_boost = function(self, card)
        --called by 
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.BLUE})
            return true end }))
        return true
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand then
            if context.joker_main then
                return {
                    message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}}, 
                    colour = G.C.XMULT,
                    Xmult_mod = card.ability.extra.Xmult
                }
            end
        end
    end,
}

local johto_mom = {
    name = "johto_mom", 
    pos = {x = 0, y = 0}, 
    config = {extra = {spend_target = 15, tax_rate = 0.2, efficiency = 0.5}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.spend_target, center.ability.extra.tax_rate, center.ability.extra.efficiency}}
        --dunno if I wanna use mult_mod2 after all
    end,
    rarity = 3,
    cost = 8,
    stage = "Other",
    ptype = "Colorless",
    atlas = "luminous_cave",
    blueprint_compat = true,
    add_to_savings = function(self, card, money)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                card.ability.extra_value = card.ability.extra_value + money
                card:set_cost()
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_val_up')})
            return true end }))
        return true
    end,
    calculate = function(self, card, context)
        if context.ending_shop and not context.blueprint then
            if card.sell_cost >= card.ability.extra.spend_target then
                local gift_type = pseudorandom(pseudoseed('mom_shopping'))
                local gift = nil
                --if gift_type > .95 then buy a matching evolution item for a random owned joker?
                if gift_type > .89 then gift = 'c_chariot'
                -- elseif gift_type > .78 then gift = G.P_CENTERS.m_mult
                elseif gift_type > .12 then gift = 'c_justice'
                else gift = 'c_tower'
                end

                local _card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, gift)
                local edition = {negative = true}
                _card:set_edition(edition, true)
                _card:add_to_deck()
                G.consumeables:emplace(_card)

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        local purchase_price = _card.sell_cost * 2
                        card.ability.extra_value = card.ability.extra_value - purchase_price
                        card:set_cost()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Spent $"..purchase_price.."!"})
                    return true end }))
            end
        end
        -- if context.cardarea == G.jokers and context.scoring_hand then
        --     if context.joker_main then
        --         return {
        --             message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}}, 
        --             colour = G.C.XMULT,
        --             Xmult_mod = card.ability.extra.Xmult
        --         }
        --     end
        -- end
    end,
}

return {name = "Pokemon Jokers 541-570", 
        list = {luminous_cave, johto_mom},
}
