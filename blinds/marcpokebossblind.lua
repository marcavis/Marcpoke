purist_disable = function(disabled, card)
  if disabled then return false end
  if card.edition then return false end
  return true
end

local ppurist={
  key = "ppurist",
  dollars = 8,
  mult = 8,
  in_pool = function(self)
    return G.GAME.challenge == "c_marcpoke_convention_concern" and math.mod(G.GAME.round_resets.ante, 8) == 0
  end,  
  boss = { showdown = true, min = 8, max = 80 },
  boss_colour = HEX("7A9616"),
  pos = { x = 0, y = 0 },
  atlas = "marcpokeboss",
  discovered = true,
  debuff = {},
  config = {disabled = false},
  set_blind = function(self)
  end,
  recalc_debuff = function(self, card, from_blind)
    if not card.edition then return true end
  end,
  press_play = function(self)
    G.GAME.blind.triggered = true
    G.GAME.blind.prepped = true
    --self.config.ptypes = determine_type()
  end,
  drawn_to_hand = function(self)
    if G.GAME.blind.prepped then
      for x,y in pairs(G.jokers.cards) do
        y:set_debuff(false)
      end
      for l,v in pairs(G.jokers.cards) do
        if purist_disable(self.config.disabled, v) then
          v:set_debuff(true)
					v:juice_up()
					G.GAME.blind:wiggle()
        end
      end
    end
  end,
  disable = function(self)
    self.config.disabled = true
  end
}

return {name = "Blinds",
        list = {ppurist}
}