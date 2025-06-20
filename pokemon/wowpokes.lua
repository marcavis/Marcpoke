local bergmite = {
    name = "bergmite", 
    pos = {x = 6, y = 4}, 
    config = {extra = {retriggers = 1, can_target = true}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {}}
    end,
    rarity = 2,
    cost = 6,
    stage = "Basic",
    ptype = "Water",
    atlas = "marcPoke6", --you'll need to change this
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.before then
            -- we haven't targeted a glass card yet
            card.ability.extra.can_target = true
        end
        if context.repetition and context.cardarea == G.play then
            if not context.end_of_round and not context.before and not context.after and not context.other_card.debuff then
                if card.ability.extra.can_target and SMODS.has_enhancement(context.other_card, 'm_glass') then
                    local target = context.other_card
                    card.ability.extra.can_target = false
                    target.bergmite_target = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                        target:juice_up()
                        return true
                        end
                    }))
                    return {
                        message = localize('k_again_ex'),
                        repetitions = card.ability.extra.retriggers,
                        card = card
                    }
                end
            end
        elseif context.destroying_card then
            -- say something to show that we are responsible for breaking the glass card
            if not context.blueprint and SMODS.has_enhancement(context.destroying_card, 'm_glass') and context.destroying_card.bergmite_target then
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'Avalanche!', colour = G.C.BLUE})
                return true
            end
            return false
        end
    end,
}

return {name = "Pokemon Jokers by wowzas", 
        list = {bergmite},
}