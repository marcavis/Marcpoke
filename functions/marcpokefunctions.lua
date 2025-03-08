--currently unused function, was used in the obsolete Alolan Muk design to decide which cards to remove
card_rating = function (card)
    local result
    if card.ability.name == "Stone Card" then
        result = 0
    elseif card.ability.name == "Default Base" then
        result = 0 + card.base.nominal
    else
        result = 50 + card.base.nominal
    end

    --stone cards have ability bonus of 50
    local bonus_chips = 0 + (card.ability.bonus or 0) + (card.ability.perma_bonus or 0)
    local foil_chips = card.edition and card.edition.chips or 0
    result = result + bonus_chips + foil_chips
    if card.seal then result = result + 100 end
    if card.edition and card.edition.polychrome then result = result + 200 end
    if card.edition and card.edition.holographic then result = result + 100 end

    return result
end

reset_gumshoos_card = function (card)
    card.ability.extra.target_rank = 'Ace'
    card.ability.extra.target_suit = 'Spades'
    local valid_gumshoos_targets = {}
    for k, v in ipairs(G.playing_cards) do
        if v.ability.effect ~= 'Stone Card' then
            valid_gumshoos_targets[#valid_gumshoos_targets+1] = v
        end
    end
    if valid_gumshoos_targets[1] then 
        local target_card = pseudorandom_element(valid_gumshoos_targets, pseudoseed('gumshoos'..G.GAME.round_resets.ante))
        card.ability.extra.target_rank = target_card.base.value
        card.ability.extra.target_suit = target_card.base.suit
        card.ability.extra.target_id = target_card.base.id
    end
end

--currently unused
remove_debuffed = function(jokers)
    local result = {}
    for _, j in ipairs(jokers) do
        if not j.debuff then
            table.insert(result, j)
        end
    end
    return result
end
