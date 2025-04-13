local luminous_cave = {
    name = "luminous_cave", 
    pos = {x = 0, y = 0}, 
    config = {extra = {Xmult = 1.5, Xmult_mod = 0.3, mult_mod2 = 2}},
    loc_vars = function(self, info_queue, center)
        -- type_tooltip(self, info_queue, center)
        return {vars = {center.ability.extra.Xmult, center.ability.extra.Xmult_mod}}
        --dunno if I wanna use mult_mod2 after all
    end,
    rarity = 3,
    cost = 8,
    stage = "Other",
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

local super_nerd = {
    name = "super_nerd", 
    pos = {x = 0, y = 0}, 
    config = {extra = {retriggers = 1}},
    loc_vars = function(self, info_queue, center)
        -- type_tooltip(self, info_queue, center)
        return {vars = {}}
        --dunno if I wanna use mult_mod2 after all
    end,
    rarity = 3,
    cost = 8,
    stage = "Other",
    atlas = "super_nerd",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if not context.end_of_round and not context.before and not context.after and not context.other_card.debuff then
              if context.other_card.edition then
                return {
                  message = localize('k_again_ex'),
                  repetitions = card.ability.extra.retriggers,
                  card = card
                }
              end
            end
          end
    end,
}

local johto_mom = {
    name = "johto_mom", 
    pos = {x = 0, y = 0}, 
    config = {extra = {mult = 0, mult_mod = 1, spend_target = 15, tax_rate = 0.2, efficiency = 1.0}},
    loc_vars = function(self, info_queue, center)
        -- type_tooltip(self, info_queue, center)
        info_queue[#info_queue+1] = {set = 'Other', key = 'moms_shopping_list'}
        return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod,
        center.ability.extra.spend_target, center.ability.extra.tax_rate, center.ability.extra.efficiency}}
        --dunno if I wanna use mult_mod2 after all
    end,
    rarity = 3,
    cost = 8,
    stage = "Other",
    atlas = "luminous_cave",
    perishable_compat = false,
    blueprint_compat = false,
    eternal_compat = false,
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
            -- "{C:green}20%{} - {C:attention}Makeover!{} (becomes {C:attention}Polychrome{})",
            -- "{C:green}20%{} - {C:attention}Random Evolution Card{}",
            -- "{C:green}20%{} - {C:attention}Pokemon Doll{}",
            -- "{C:green}20%{} - {C:attention}Random Berries{}",
            -- "{C:green}19%{} - {C:attention}Repel{}",
            -- "{C:green}1%{} - {C:attention}Mega Stone{}",
    calculate = function(self, card, context)
    if context.ending_shop and not context.blueprint then
        if card.sell_cost >= card.ability.extra.spend_target then
            local gift_type = pseudorandom(pseudoseed('mom_shopping'))
            local gift = nil
            local purchase_price = 0
            local gift_success = false
            --if gift_type > .95 then buy a matching evolution item for a random owned joker?
            if gift_type > .90 then gift = 'makeover'
            elseif gift_type > .80 then gift = 'smart_evo'
            elseif gift_type > .60 then gift = 'evo'
            elseif gift_type > .40 then gift = 'doll'
            elseif gift_type > .20 then gift = 'berries'
            elseif gift_type > .01 then gift = 'repel'
            else gift = 'mega'
            end
            
            if gift == 'makeover' then
                if not card.edition or (card.edition and not card.edition.negative and not card.edition.polychrome) then
                    gift_success = true
                    purchase_price = 10
                    card:set_edition({polychrome = true}, true)
                end
            elseif gift == 'repel' then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    purchase_price = 12
                    gift_success = true
                    local _card = create_card('Item', G.consumeables, nil, nil, nil, nil, "c_marcpoke_repel")
                    _card:add_to_deck()
                    G.consumeables:emplace(_card)
                    card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize("poke_plus_pokeitem"), colour = G.C.PURPLE})
                end
            elseif gift == 'smart_evo' then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    local evo_item_keys = {}
                    for k, v in pairs(G.jokers.cards) do
                        if v.config.center.item_req then
                            if type(v.config.center.item_req) == "table" then
                                item_key = "c_poke_"..pseudorandom_element(v.config.center.item_req, pseudoseed('match'))
                                if not next(SMODS.find_card(item_key)) then
                                    local already_created = nil
                                    for k, v in pairs(self.config.c_keys) do
                                        if v == item_key then
                                            already_created = true
                                        end
                                    end
                                    if not already_created then
                                        table.insert(evo_item_keys, item_key)
                                    end
                                end
                            else
                                item_key = "c_poke_"..v.config.center.item_req
                                if not next(SMODS.find_card(item_key)) then
                                    local already_created = nil
                                    for k, v in pairs(self.config.c_keys) do
                                        if v == item_key then
                                            already_created = true
                                        end
                                    end
                                    if not already_created then
                                        table.insert(evo_item_keys, item_key)
                                    end
                                end
                            end
                        end
                    end
                    if #evo_item_keys > 0 then
                        gift_success = true
                        local evo_item = create_card("Item", G.pack_cards, nil, nil, true, true, pseudorandom_element(evo_item_keys, pseudoseed('evoitem')), nil)
                        purchase_price = evo_item.sell_cost * 2
                        evo_item:add_to_deck()
                        G.consumeables:emplace(evo_item)
                        card_eval_status_text(evo_item, 'extra', nil, nil, nil, {message = localize("poke_plus_pokeitem"), colour = G.C.PURPLE})
                    end
                end
            elseif gift == 'evo' then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    gift_success = true
                    local evo_items = {"thunderstone", "moonstone", "firestone", "waterstone",
                    "leafstone", "sunstone", "shinystone", "duskstone", "kingsrock", "linkcable", "upgrade", "dubious_disc", "prismscale"}
                    local _card = create_card("Item", G.pack_cards, nil, nil, true, true, 'c_poke_'..pseudorandom_element(evo_items, pseudoseed('evoitem')), nil)
                    purchase_price = _card.sell_cost * 2
                    _card:add_to_deck()
                    G.consumeables:emplace(_card)
                    card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize("poke_plus_pokeitem"), colour = G.C.PURPLE})
                end
            elseif gift == 'mega' then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    gift_success = true
                    local _card = create_card("Item", G.pack_cards, nil, nil, true, true, 'c_poke_megastone', nil)
                    purchase_price = _card.sell_cost * 2
                    _card:add_to_deck()
                    G.consumeables:emplace(_card)
                    card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize("poke_plus_pokeitem"), colour = G.C.PURPLE})
                end
            elseif gift == 'doll' then
                if #G.jokers.cards < G.jokers.config.card_limit then
                    local dolls = {"snorlax_doll", "clefairy_doll"}
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        play_sound('timpani')
                        local temp_card = {set = "Joker", area = G.jokers, key = 'j_marcpoke_'..pseudorandom_element(dolls, pseudoseed('doll'))}
                        local _card = SMODS.create_card(temp_card)
                        _card:add_to_deck()
                        G.jokers:emplace(_card)
                        purchase_price = _card.sell_cost * 2
                        return true end }))
                    delay(0.3)
                    
                    gift_success = true
                end
            end
            
            if not gift_success then --cheer and gain mult
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.BLUE})
            end
            -- local _card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, gift)
            -- local edition = {negative = true}
            -- _card:set_edition(edition, true)
            -- _card:add_to_deck()
            -- G.consumeables:emplace(_card)
            
            if purchase_price > 0.1 then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        --local purchase_price = _card.sell_cost * 2
                        card.ability.extra_value = card.ability.extra_value - purchase_price
                        card:set_cost()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Spent $"..purchase_price.."!"})
                        return true end }))
            end
        end
    end
    if context.cardarea == G.jokers and context.scoring_hand then
        if context.joker_main then
            return {
                message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
                colour = G.C.MULT,
                mult_mod = card.ability.extra.mult
            }
        end
    end

    end,
}

return {name = "Pokemon Jokers 541-570", 
        list = {luminous_cave, super_nerd, johto_mom},
}
