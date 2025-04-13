purist_disable = function(disabled, card)
  if disabled then return false end
  if card.edition then return false end
  return true
end

local ppurist={
  key = "ppurist",
  dollars = 20,
  mult = 16,
  boss = { showdown = true, min = 8, max = 80 },
  boss_colour = HEX("7A9616"),
  pos = { x = 0, y = 0 },
  atlas = "marcpokeboss",
  discovered = true,
  debuff = {},
  config = {disabled = false},
  set_blind = function(self)
    for x, y in ipairs(G.deck.cards) do
      if not y.edition then y:set_debuff(true) end
    end
  end,
  recalc_debuff = function(self, card, from_blind)
    --will check later
    --return goose_disable(self.config.disabled, card, self.config.ptypes)
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