local marcavis_alolan_muk={
    name = "alolan_muk", 
    pos = {x = 10, y = 6}, 
    --will delete the weakest <targets> out of the <choices>; e.g. 2 weakest out of 7 random cards
    config = {extra = {mult = 2, Xmult = 1.5, choices = 7, targets = 2}},
    loc_vars = function(self, info_queue, center)
      type_tooltip(self, info_queue, center)
      return {vars = {center.ability.extra.choices, center.ability.extra.targets,
                        center.ability.extra.mult, center.ability.extra.Xmult, G.GAME.starting_deck_size, G.GAME.starting_deck_size + 12, 
                      (G.playing_cards and (#G.playing_cards - G.GAME.starting_deck_size) or 0) * center.ability.extra.mult}}
    end,
    rarity = 3, 
    cost = 8, 
    stage = "One", 
    ptype = "Dark",
    set_sprites = function(self, card, front)
        card.config.center.atlas = "poke_Pokedex1"
        card.children.center.atlas = G.ASSET_ATLAS['poke_Pokedex1']
        card.children.center:reset()
    end,
    blueprint_compat = true,
    calculate = function(self, card, context)
      if context.end_of_round and not context.individual and not context.repetition then
        local targets = {}
        for i = 1, math.min(card.ability.extra.choices, #G.playing_cards - 1) do
            targets[i] = pseudorandom_element(G.playing_cards, pseudoseed('alolan_muk'))
            print(targets[i].base.nominal, targets[i].base.suit, " worth", card_rating(targets[i]))
        end
        
        table.sort(targets, function(a, b) return card_rating(a) < card_rating(b) end)
        local actually_removed = {}
        for j = 1, math.min(card.ability.extra.targets, #targets) do
            print("Deleting ".. targets[j].base.nominal, targets[j].base.suit)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function() 
                    if targets[j].ability.name == 'Glass Card' then 
                        targets[j]:shatter()
                    else
                        targets[j]:start_dissolve()
                    end
                return true end }))
        end
        delay(0.3)
        for i = 1, #G.jokers.cards do
            for j = 1, #targets do
                G.jokers.cards[i]:calculate_joker({remove_playing_cards = true, removed = {targets[j]}})
            end
        end
        card:juice_up()
      end
    end,
}

--disabled
local joke_exploud = {
    name = "joke_exploud", 
    pos = {x = 3, y = 4}, 
    config = {extra = {}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {}}
    end,
    rarity = 2, 
    cost = 8, 
    stage = "Two", 
    ptype = "Colorless",
    set_sprites = function(self, card, front)
        card.config.center.atlas = "poke_Pokedex3"
        card.children.center.atlas = G.ASSET_ATLAS['poke_Pokedex3']
        card.children.center:reset()
    end,
    blueprint_compat = true,
    add_to_deck = function(self, card, from_debuff)
        G.SETTINGS.SOUND.volume = G.SETTINGS.SOUND.volume + 50
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.SETTINGS.SOUND.volume = G.SETTINGS.SOUND.volume - 50
    end,
    calculate = function(self, card, context)
        --just changes volume
    end,
}

--couldn't make it to work i think
local maractus = {
    name = "maractus", 
    pos = {x = 6, y = 4}, 
    config = {extra = {odds = 4}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), center.ability.extra.odds}}
    end,
    rarity = 2,
    cost = 6,
    stage = "Basic",
    ptype = "Grass",
    set_sprites = function(self, card, front)
        card.config.center.atlas = "poke_Pokedex5"
        card.children.center.atlas = G.ASSET_ATLAS['poke_Pokedex5']
        card.children.center:reset()
    end,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand then
            if context.joker_main then
                local index = pseudorandom('maractus', 1, #context.scoring_hand)
                local copy
                --copy:add_to_deck()
                --SMODS.add
                --G.deck.config.card_limit = G.deck.config.card_limit + 5
                local card_index = 1
                for i, v in ipairs(G.playing_cards) do
                    if v == context.scoring_hand[index] then
                        card_index = i
                        copy = copy_card(v, nil, nil, G.playing_card)
                    end
                end

                copy:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, copy)
                --table.insert(G.deck.cards, copy)
                G.hand:emplace(copy)
                copy.states.visible = nil


                G.E_MANAGER:add_event(Event({
                    func = function()
                        copy:start_materialize()
                        return true
                    end
                })) 
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        local moved_index = 1
                        for i, v in ipairs(G.playing_cards) do
                            if v == context.scoring_hand[index] then
                                moved_index = i
                                table.remove(G.playing_cards, i)
                                -- if v.ability.name == 'Glass Card' then 
                                --     v:shatter()
                                -- else
                                --     v:start_dissolve()
                                -- end
                                break
                            end
                        end

                        for i, v in ipairs(G.discard.cards) do
                            if v == context.scoring_hand[index] then 
                            --they aren't going to be equal, something changes when the card is discarded/played
                            --if v.base
                            
                                moved_index = i
                                print("deleted on deck too")
                                table.remove(G.discard.cards, i)
                                -- if v.ability.name == 'Glass Card' then 
                                --     v:shatter()
                                -- else
                                --     v:start_dissolve()
                                -- end
                                break
                            end
                            --print(i, ":", v.config.card.name)
                        end
                        return true end }))
            end
        end
    end,
}


return {}