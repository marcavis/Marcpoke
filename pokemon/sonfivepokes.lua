local darkrai = {
    name = "darkrai", 
    pos = {x = 8, y = 8}, 
    soul_pos = {x = 9, y = 8},
    config = {extra = {}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        info_queue[#info_queue+1] = { set = 'Spectral', key = 'c_poke_nightmare', poke_add_desc = true}
        return {vars = {}}
    end,
    rarity = 4, 
    cost = 10, 
    stage = "Legendary", 
    ptype = "Dark",
    atlas = "marcPoke4",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.setting_blind and context.blind == G.P_BLINDS.bl_small then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                local _card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, "c_poke_nightmare")
                _card:add_to_deck()
                G.consumeables:emplace(_card)
                card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize("k_plus_spectral"), colour = G.C.PURPLE})
            end
            local energies = {}
            for _c, item in ipairs(G.consumeables.cards) do
                --if nrg.ability.set == "Energy" and nrg.edition and nrg.edition.negative then
                if item.ability.set == "Energy" then
                    energies[#energies+1] = item
                end
            end
            for _j, joker in ipairs(G.jokers.cards) do
                for _c, nrg in ipairs(energies) do
                    --to ease end of round calculations, colorless energy CAN'T be used in non-colorless jokers.
                    if energy_matches(joker, nrg.config.center.etype, false) then
                        energy_shift(joker, 1, joker.ability.extra.ptype, false, false)        
                        joker.ability.extra.borrowed_energy = (joker.ability.extra.borrowed_energy or 0) + 1
                        --TODO: remove prints later
                        print(joker.ability.name, joker.ability.extra.borrowed_energy, " energy borrowed")
                    end
                end
            end
        end
        if context.end_of_round and not context.individual and not context.repetition then
            --TODO: Maybe this code should be done elsewhere - what if Darkrai is debuffed or sold when the round ends?
            for _j, joker in ipairs(G.jokers.cards) do
                if joker.ability.extra.borrowed_energy then
                    energy_shift(joker, -joker.ability.extra.borrowed_energy, joker.ability.extra.ptype, false, false)
                    joker.ability.extra.borrowed_energy = 0
                end
            end
        end
    end
}

return {name = "Sonfive ideas", 
        list = {darkrai},
}