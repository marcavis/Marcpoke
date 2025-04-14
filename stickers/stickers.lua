local soccer_sticker = {
    key = "soccer_sticker",
    should_apply = function(self, card, center, area)
    	return false
  	end,
	  loc_vars = function(self, info_queue, card)
        if card.ability and card.ability.extra then
            if card.ability.name == "cinderace" then
                return { vars = {card.ability.extra.Xmult_mod * 2, 1.0 + card.ability.extra.Xmult_mod, card.ability.extra.Xmult_mod}}
            else
                return { vars = {0.4, 1.2, 0.2}}
            end
        end
	  end,
      
    badge_colour = HEX("f07090"),
    default_compat = true,
    prefix_config = {key = false},
    rate = 0.00,
    atlas = "stickers",
    pos = { x = 0, y = 0 },
    sets = {
    	Joker = true
    },
	config = {card_pointer = nil},
    apply = function(self, card, val)
    	card.ability[self.key] = val
  	end,
}

local rebel_sticker = {
    key = "rebel_sticker",
    should_apply = function(self, card, center, area)
    	return false
  	end,
    loc_vars = function(self, info_queue, card)
        return { vars = {}}
    end,
      
    badge_colour = HEX("802090"),
    default_compat = true,
    prefix_config = {key = false},
    rate = 0.00,
    atlas = "stickers",
    pos = { x = 1, y = 0 },
    sets = {
    	Joker = true
    },
	config = {card_pointer = nil},
    apply = function(self, card, val)
    	card.ability[self.key] = val
        if not card.ability or not card.ability.extra then return end
        if type(card.ability.extra) ~= "table" then print (card.ability); return end
        for i, v in pairs(card.ability.extra) do
            if i == "mult" or i == "chips" then card.ability.extra[i] = -v end
            if i == "h_size" or i == "hands" or i == "money_mod" or i == "discards" then card.ability.extra[i] = -v end
            if i == "Xmult" then card.ability.extra[i] = 1/v end
        end
  	end,
}

local aging_sticker = {
    key = "aging_sticker",
    should_apply = function(self, card, center, area)
    	return false
  	end,
	  loc_vars = function(self, info_queue, card)
        return { vars = {}}
	  end,
      
    badge_colour = HEX("9030A0"),
    default_compat = true,
    prefix_config = {key = false},
    rate = 0.00,
    atlas = "stickers",
    pos = { x = 2, y = 0 },
    sets = {
    	Joker = true
    },
	config = {card_pointer = nil},
    apply = function(self, card, val)
    	card.ability[self.key] = val
        -- G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        -- G.E_MANAGER:add_event(Event({
        --     trigger = 'before',
        --     delay = 0.0,
        --     func = (function()
        --             local _card = create_card('Energy', G.consumeables, nil, nil, nil, nil, nil, 'pory')
        --             _card:add_to_deck()
        --             G.consumeables:emplace(_card)
        --             G.GAME.consumeable_buffer = 0
        --         return true
        --     end)}))
        -- card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize("poke_plus_energy"), colour = G.ARGS.LOC_COLOURS["pink"]})
  	end,
}

return
{
  name = "Stickers",
  list = {soccer_sticker, rebel_sticker, aging_sticker}
}