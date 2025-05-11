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

local mutant_volcarona = {
    name = "mutant_volcarona", 
    pos = {x = 3, y = 10}, 
    config = { extra = {
        mult = 0, mult_mod = 1, threshold = 1
    }},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod, center.ability.extra.threshold}}
    end,
    rarity = "Legendary", 
    cost = 8,
    ptype = "Fire",
    stage = "Basic", 
    atlas = "marcPoke5",
    aux_poke = true,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand then
            if context.joker_main then
                return {
                    message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
                    colour = G.C.MULT,
                    mult_mod = card.ability.extra.mult
                }
            end
        end
        if context.end_of_round and not context.individual and not context.repetition then
            -- local cards = {}
            -- for i = 1, 2 do
            --     cards[i] = create_playing_card({
            --         front = pseudorandom_element(G.P_CARDS, pseudoseed('muk')), 
            --         center = G.P_CENTERS.c_base}, G.hand, nil, nil, {G.C.PURPLE
            --     })
            -- end
            -- playing_card_joker_effects(cards);

            local targets = {}
            local cards_destroyed = 0
            for _, v in ipairs(G.playing_cards) do
                local chip_value = 0 + (v.ability.bonus or 0) + (v.ability.perma_bonus or 0)
                chip_value = chip_value + (v.edition and v.edition.chips or 0) + v.base.nominal
                if chip_value <= card.ability.extra.threshold then
                    cards_destroyed = cards_destroyed + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function() 
                            if v.ability.name == 'Glass Card' then 
                                v:shatter()
                            else
                                v:start_dissolve()
                            end
                            return true end }))
                    delay(0.3)
                    for i = 1, #G.jokers.cards do
                        G.jokers.cards[i]:calculate_joker({remove_playing_cards = true, removed = {v}})
                    end
                end
            end
            if cards_destroyed > 0 then
                card:juice_up()
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.BLUE})
                card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.mult_mod * cards_destroyed)
            end
            card.ability.extra.threshold = card.ability.extra.threshold + 1
        end
    end
}

return {
    name = "Marcpoke Jokers", 
    -- list = {sigilyph},
    list = {mutant_volcarona}
}
