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

--a near-copy of Pokermon's energize function
--Ideally, we could implement whatever this needs in the energize function
energy_shift = function(card, energy_delta, etype, evolving, silent)
    local rounded = nil
    local frac = nil
    local frac_added = nil
    if type(card.ability.extra) == "table" then
        for name, _ in pairs(energy_values) do
            local data = card.ability.extra[name]
            if type(data) == "number" then
                local addition = energy_values[name] * energy_delta
                local previous_mod = nil
                local updated_mod = nil
                if name == "mult_mod" or name == "chip_mod" then previous_mod = card.ability.extra[name] end
                if (card.ability.extra.ptype ~= "Colorless" and not card.ability.colorless_sticker) and etype == "Colorless" then
                    card.ability.extra[name] = data + (card.config.center.config.extra[name] * addition/2) * (card.ability.extra.escale or 1)
                else
                    card.ability.extra[name] = data + (card.config.center.config.extra[name] * addition) * (card.ability.extra.escale or 1)
                end
                updated_mod = card.ability.extra[name]
                rounded, frac = round_energy_value(card.ability.extra[name], name)
                card.ability.extra[name] = rounded
                if frac then
                    if name == "mult_mod" or name == "chip_mod" then
                        set_frac(card, frac, name, rounded > 0, updated_mod/previous_mod)
                    else
                        set_frac(card, frac, name, rounded > 0)
                    end
                    frac = nil
                    frac_added = true
                end
            end
        end
    elseif type(card.ability.extra) == "number" then
        local mults = {"Joker" , "Jolly Joker", "Zany Joker", "Mad Joker", "Crazy Joker", "Droll Joker", "Half Joker", "Mystic Summit", "Gros Michel", "Popcorn"}
        local mult_mods = {"Greedy Joker", "Lusty Joker", "Wrathful Joker", "Gluttonous Joker", "Fibonacci", "Abstract Joker", "Even Steven", "Ride the Bus", "Green Joker", "Red Card", "Erosion",
        "Fortune Teller", "Pokedex", "Flash Card", "Spare Trousers", "Smiley Face", "Onyx Agate", "Shoot the Moon", "Bootstraps"}
        local chipss = {"Sly Joker", "Wily Joker", "Clever Joker", "Devious Joker", "Crafty Joker", "Stuntman"}
        local chip_mods = {"Banner", "Scary Face", "Odd Todd", "Runner", "Blue Joker", "Hiker", "Square Joker", "Stone Joker", "Bull", "Castle", "Arrowhead", "Wee Joker"}
        local Xmults = {"Loyalty Card", "Blackboard", "Cavendish", "Card Sharp", "Ramen", "Acrobat", "Flower Pot", "Seeing Double", "The Duo", "The Trio", "The Family", "The Order", "The Tribe", 
        "Driver's License"}
        local Xmult_mods = {"Joker Stencil", "Steel Joker", "Constellation", "Madness", "Vampire", "Hologram", "Baron", "Obelisk", "Photograph", "Lucky Cat", "Baseball Card", "Everstone", "Ancient Joker",
        "Campfire", "Throwback", "Bloodstone", "Glass Joker", "The Idol", "Hit the Road", "Canio", "Triboulet", "Yorick"}
        local monies = {"Delayed Gratification", "Egg", "Cloud 9", "Rocket", "Gift Card", "Reserved Parking", "Mail-In Rebate", "To the Moon", "Golden Joker", "Trading Card", "Golden Ticket", "Rough Gem",
        "Satellite", "Matador"}
        
        local scoring_values = {mult = mults, mult_mod = mult_mods, chips = chipss, chip_mod = chip_mods, Xmult = Xmults, Xmult_mod = Xmult_mods, money = monies}
        for k, v in pairs(scoring_values) do
            for x, y in pairs(v) do
                if card.ability.name == y then
                    local increase = energy_values[k] * energy_delta
                    if not card.ability.colorless_sticker and etype == "Colorless" then
                        increase = increase/2
                    end
                    card.ability.extra = card.ability.extra + (card.config.center.config.extra * increase)
                end
            end
        end
    else
        local increase = nil
        if (card.ability.mult and card.ability.mult > 0) or (card.ability.t_mult and card.ability.t_mult > 0) then
            increase = energy_values.mult * energy_delta
        elseif (card.ability.t_chips and card.ability.t_chips > 0) then
            increase = energy_values.chips * energy_delta
        end
        if increase then
            if not card.ability.colorless_sticker and etype == "Colorless" then
                increase = increase/2
            end
            if (card.ability.mult and card.ability.mult > 0) then
                card.ability.mult = card.ability.mult + (card.config.center.config.mult * increase)
            end
            if (card.ability.t_mult and card.ability.t_mult > 0) then
                card.ability.t_mult = card.ability.t_mult + (card.config.center.config.t_mult * increase)
            end
            if (card.ability.t_chips and card.ability.t_chips > 0) then
                card.ability.t_chips = card.ability.t_chips + (card.config.center.config.t_chips * increase)
            end
        end
    end
    if not silent then
        if energy_delta > 0 then
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("poke_energized_ex")..energy_delta, colour = G.C.CHIPS})
        elseif energy_delta < 0 then
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("poke_deenergized_ex")..energy_delta, colour = G.C.CHIPS})
        end
    end
end