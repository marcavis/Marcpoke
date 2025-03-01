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

return {}