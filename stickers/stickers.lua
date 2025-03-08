local soccer_sticker = {
    key = "soccer_sticker",
    should_apply = function(self, card, center, area)
    	return false
  	end,
	  loc_vars = function(self, info_queue, card)
        if card.ability and card.ability.extra then
            if card.ability.name == "cinderace" then
                return { vars = {card.ability.extra.ball_effect}}
            else
                return { vars = {1}}
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
	config = {card_pointer = nil, extra={effect = 1.2}, base_effect = 1.2},
    apply = function(self, card, val)
    	card.ability[self.key] = val
  	end,
}

return
{
  name = "Stickers",
  list = {soccer_sticker}
}