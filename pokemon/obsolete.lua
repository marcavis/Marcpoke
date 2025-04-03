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

local old_toxtricity_lowkey = {
    name = "toxtricity_lowkey", 
    pos = {x = 0, y = 3}, 
    config = {extra = {}},
    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        return {vars = {}}
    end,
    rarity = 2, 
    cost = 8, 
    stage = "One", 
    ptype = "Lightning",
    atlas = "marcPoke8",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if not context.repetition and not context.individual and context.end_of_round and not context.blueprint then
            for _, nrg in ipairs(G.consumeables.cards) do
                local can_make_negative = not nrg.edition or (nrg.edition and not nrg.edition.negative)
                if nrg.ability and nrg.ability.set == "Energy" and can_make_negative then
                    nrg:set_edition({negative = true}, true)
                    card_eval_status_text(nrg, 'extra', nil, nil, nil, {message = "Negative!", colour = G.C.PURPLE})
                end
            end
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