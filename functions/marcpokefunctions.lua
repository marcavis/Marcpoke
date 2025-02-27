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