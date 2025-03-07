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

local backup_bills_pc = {
    name = "bills_pc", 
    pos = {x = 0, y = 0}, 
    config = {extra = {location = nil, j_size = 2}, debug_iter = 0},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {}}
    end,
    rarity = 3,
    cost = 8,
    stage = "Other",
    ptype = "Colorless",
    atlas = "bills_pc",
    blueprint_compat = false,
    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.j_size
    end,
    remove_from_deck = function(self, card, from_debuff)
        for i = 1, #G.jokers.cards do
            -- if a joker has been debuffed by bill and there's no bill to the left of it, then un-debuff it
            local joker = G.jokers.cards[i]
            if joker.ability.debuff_sources and joker.ability.debuff_sources['bill_pc'] then
                if i == 1 or G.jokers.cards[i-1].ability.name ~= self.name then
                    SMODS.debuff_card(joker, nil, 'bill_pc')
                end
            end
            if joker.debuff then
                joker:set_debuff()
            end
        end
        G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.j_size
    end,
    update = function(self, card, dt)
        -- if it's in the shop or collection screen
        if card.area ~= G.jokers then return end
        card.ability.debuff_sources = card.ability.debuff_sources or {}

        -- check for moved jokers and also get bill's location
        local bill_loc = nil
        for i = 1, #G.jokers.cards do
            -- if a joker has been debuffed by bill and there's no bill to the left of it, then un-debuff it
            if G.jokers.cards[i].ability.debuff_sources and G.jokers.cards[i].ability.debuff_sources['bill_pc'] then
                if i == 1 or G.jokers.cards[i-1].ability.name ~= self.name then
                    SMODS.debuff_card(G.jokers.cards[i], nil, 'bill_pc')
                end
            end
            -- while we're looking through the jokers, also confirm bill's location
            if G.jokers.cards[i] == card then
                bill_loc = i
            end
        end
        card.ability.extra.location = bill_loc

        -- should never occur, but might?
        if not bill_loc or G.jokers.cards[bill_loc] ~= card then
            print("CAN'T FIND THE PC?! Contact Kek and marcavis")
            return
        end

        --force the PC into the leftmost spot (unless Bill's PC is the only kind of joker in the jokers area)
        if bill_loc == #G.jokers.cards and not card.states.drag.is and #SMODS.find_card(card.config.center.key) < #G.jokers.cards then
            -- if x is true, return 1, otherwise return false
            local bool_to_int = function(x) return x and 1 or 0 end
            -- G.jokers:sort(function(a,b) return bool_to_int(a == card) < bool_to_int(b == card) end)
            -- G.jokers:sort()
            table.sort(G.jokers.cards, function (a, b) return (a.unique_val + bool_to_int(a == card)) > (b.unique_val + bool_to_int(b == card)) end )
        end

        local right_card = G.jokers.cards[bill_loc + 1]

        if not right_card then
            if not card.ability.debuff_sources['bill_pc_self'] then
                SMODS.debuff_card(card, true, 'bill_pc_self')
            end
            return
        end
        if right_card.debuff and not card.debuff then return end

        right_card.ability.debuff_sources = right_card.ability.debuff_sources or {}

        if not right_card.debuff then
            if right_card.ability.debuff_sources['bill_pc'] then
                if not card.ability.debuff_sources['bill_pc_self'] then
                    SMODS.debuff_card(card, true, 'bill_pc_self')
                end
                return
            end
            if card.ability.debuff_sources['bill_pc_self'] then
                SMODS.debuff_card(card, nil, 'bill_pc_self')
            end
            card:set_debuff()
            if card.debuff then return end
            -- right is not debuffed and we are not debuffed
            SMODS.debuff_card(right_card, true, 'bill_pc')
            if not right_card.debuff then
                if not card.ability.debuff_sources['bill_pc_self'] then
                    SMODS.debuff_card(card, true, 'bill_pc_self')
                end
            end
            return
        else
            -- both are debuffed
            if card.ability.debuff_sources['bill_pc_self'] then
                SMODS.debuff_card(card, nil, 'bill_pc_self')
            end
            card:set_debuff()
            if not card.debuff then return end
            if right_card.ability.debuff_sources['bill_pc'] then
                SMODS.debuff_card(right_card, nil, 'bill_pc')
                SMODS.recalc_debuff(right_card)
            end
        end
    end,
}

return {name = "Pokemon Jokers 541-570", 
        list = {luminous_cave},
}
