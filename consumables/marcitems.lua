local bills_pc = {
    name = "bills_pc",
    key = "bills_pc",
    set = "Item",
    config = {extra = {location = nil, j_size = 1, c_size = 1}, debug_iter = 0},
    loc_vars = function(self, info_queue, center)
        --info_queue[#info_queue+1] = {set = 'Other', key = 'endless'}
        return {vars = {center.ability.extra.j_size, center.ability.extra.c_size}}
    end,
    pos = { x = 0, y = 0 },
    atlas = "bills_pc",
    cost = 4,
    --hidden = true,
    unlocked = true,
    discovered = true,
    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.j_size
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.c_size
    end,
    remove_from_deck = function(self, card, from_debuff)
        --TODO: change this?

        --undebuff one bills-pc debuffed joker, starting from the left
        for i = 1, #G.jokers.cards do
            local joker = G.jokers.cards[i]
            if joker.ability.debuff_sources and joker.ability.debuff_sources['bill_pc'] then 
                SMODS.debuff_card(joker, nil, 'bill_pc')
                break
            end
        end
        G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.j_size
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.c_size
    end,
    update = function(self, card, dt)
        if G.jokers.config.card_count >= G.jokers.config.card_limit then
            card.ability.eternal = true
        else
            card.ability.eternal = false
        end


        if card.area ~= G.consumeables then return end
        local billspcs = SMODS.find_card(card.config.center.key)
        if card ~= billspcs[1] then return end

        --when all joker slots are used up, (or over limit), all bills'pcs will disable a joker
        --if there's one empty Joker spot, one Bill's PC won't debuff anyone, and so on
        local jokers_to_debuff = #billspcs - (G.jokers.config.temp_limit - G.jokers.config.card_count)
        --let's not try to debuff more jokers than actually exist, too
        jokers_to_debuff = math.min(jokers_to_debuff, G.jokers.config.card_count)
        for i = 1, G.jokers.config.card_count - jokers_to_debuff do
            local joker = G.jokers.cards[i]
            if joker and joker.ability.debuff_sources and joker.ability.debuff_sources['bill_pc'] then 
                SMODS.debuff_card(joker, nil, "bill_pc")
            end
        end
        
        for i = G.jokers.config.card_count - jokers_to_debuff + 1, G.jokers.config.card_count do
            local joker = G.jokers.cards[i]
            --check if this joker exists, lest we try to debuff G.jokers.cards[-1]
            if joker then
                SMODS.debuff_card(joker, true, "bill_pc")
            end
        end
    end,
    can_use = function(self, card)
        return false
    end,
    use = function(self, card, area, copier) end
  }

  return {name = "Items",
  list = {bills_pc}
}