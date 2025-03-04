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

local bills_pc = {
    name = "bills_pc", 
    pos = {x = 0, y = 0}, 
    config = {extra = {debuffed_by_me = 1, checked_debuffs = false}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {}}
    end,
    debuff_neighbor = function(self, center)
        if G.jokers and #G.jokers.cards > #SMODS.find_card(center.config.center.key) then
            local debuff_now = (center.rank + 1) % #G.jokers.cards
            if debuff_now == 0 then debuff_now = #G.jokers.cards end
            G.jokers.cards[debuff_now].debuff = true
            center.ability.extra.debuffed_by_me = debuff_now
            for i, j in ipairs(G.jokers.cards) do
                if i ~= debuff_now then
                    G.jokers.cards[i].debuff = false
                end
            end
        end
    end,
    update = function(self, card, dt)
        self.debuff_neighbor(self, card)
    end,
    rarity = 3,
    cost = 8,
    stage = "Other",
    ptype = "Colorless",
    atlas = "bills_pc",
    blueprint_compat = false,
    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + 2
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - 2
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers then
            self.debuff_neighbor(self, card)
        end
    end,
}

return {name = "Pokemon Jokers 541-570", 
        list = {luminous_cave, bills_pc},
}
