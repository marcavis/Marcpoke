local stunky = {
    name = "stunky",
    pos = {x = 5, y = 3}, 
    config = {extra = {reduction_limit = 25, volatile = 'left', rounds = 5}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        info_queue[#info_queue+1] = {set = 'Other', key = 'poke_volatile_'..center.ability.extra.volatile}
        local reduction = 0
        if G.jokers and center.rank < G.jokers.config.card_count then
            local next_poke_value = G.jokers.cards[center.rank + 1].sell_cost
            reduction = math.min(center.ability.extra.reduction_limit, next_poke_value)
        end
        return {vars = {reduction, center.ability.extra.reduction_limit, center.ability.extra.rounds}}
    end,
    rarity = 2, 
    cost = 6,
    ptype = "Dark",
    stage = "Basic", 
    atlas = "marcPoke4",
    blueprint_compat = false,
    volatile = true,
    
    calculate = function(self, card, context)
        --and not blueprint?
        if context.setting_blind and volatile_active(self, card, card.ability.extra.volatile) and not context.blueprint then
            local reduction = 0
            if card.rank < G.jokers.config.card_count then
                local next_poke_value = G.jokers.cards[card.rank + 1].sell_cost
                reduction = math.min(card.ability.extra.reduction_limit, next_poke_value) / 100
                G.GAME.blind.chips = G.GAME.blind.chips * (1 - reduction)
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.jokers.cards[card.rank + 1].ability.fainted = G.GAME.round
                        G.jokers.cards[card.rank + 1]:set_debuff()
                        return true
                    end
                })) 
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('poke_poison_gas_ex')})
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        card.ability.fainted = G.GAME.round
                        card:set_debuff()
                        return true
                    end
                })) 

            end
        end
        return level_evo(self, card, context, "j_marcpoke_skuntank")
    end,
}

local skuntank = {
    name = "skuntank",
    pos = {x = 6, y = 3}, 
    config = {extra = {reduction_limit = 50, volatile = 'left'}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        info_queue[#info_queue+1] = {set = 'Other', key = 'poke_volatile_'..center.ability.extra.volatile}
        local reduction = 0
        if G.jokers and center.rank < G.jokers.config.card_count then
            local next_poke_value = G.jokers.cards[center.rank + 1].sell_cost
            local type_multiplier = G.jokers.cards[center.rank + 1].ability.extra.ptype == "Fire" and 3 or 2
            reduction = math.min(center.ability.extra.reduction_limit, next_poke_value * type_multiplier)
        end
        return {vars = {reduction, center.ability.extra.reduction_limit,}}
    end,
    rarity = "poke_safari", 
    cost = 8,
    ptype = "Dark",
    stage = "One", 
    atlas = "marcPoke4",
    blueprint_compat = false,
    volatile = true,
    calculate = function(self, card, context)
        --and not blueprint?
        if context.setting_blind and volatile_active(self, card, card.ability.extra.volatile) and not context.blueprint then
            local reduction = 0
            if card.rank < G.jokers.config.card_count then
                local next_poke_value = G.jokers.cards[card.rank + 1].sell_cost
                local type_multiplier = G.jokers.cards[card.rank + 1].ability.extra.ptype == "Fire" and 3 or 2
                reduction = math.min(card.ability.extra.reduction_limit, next_poke_value * type_multiplier) / 100
                G.GAME.blind.chips = G.GAME.blind.chips * (1 - reduction)
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                -- G.E_MANAGER:add_event(Event({
                --     func = function()
                --         print("killing"..G.jokers.cards[card.rank + 1].ability.name)
                --         G.jokers.cards[card.rank + 1].ability.fainted = G.GAME.round
                --         G.jokers.cards[card.rank + 1].debuff = true
                --         G.jokers.cards[card.rank + 1]:set_debuff()
                --         return true
                --     end
                -- })) 
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('poke_poison_gas_ex')})
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        print("killing"..card.rank)
                        --card.ability.fainted = G.GAME.round
                        --card.debuff = true
                        card:set_debuff()
                        return true
                    end
                })) 
                return {}
            end
        end
    end,
}


return {name = "Vagabond Aeon Jokers", 
list = {stunky, skuntank},
}
