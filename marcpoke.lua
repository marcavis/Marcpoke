assert(SMODS.load_file("functions/marcpokefunctions.lua"))()

default_poke_custom_prefix = "marcpoke"

--Required by the pokemon family function (right click on a pokemon joker)
table.insert(family, {"trubbish", "garbodor"})
table.insert(family, {"timburr", "gurdurr", "conkeldurr"})
table.insert(family, {"yungoos", "gumshoos"})
table.insert(family, {"alolan_grimer", "alolan_muk"})


table.insert(family, {"toxtricity"})
table.insert(family, {"chatot"})
table.insert(family, {"maractus"})
table.insert(family, {"cinderace"})
table.insert(family, {"shuppet", "banette"})
table.insert(family, {"scraggy", "scrafty"})
table.insert(family, {"stunky", "skutank"})
--table.insert(family, {"chikorita", "bayleef", "meganium"})


-- Get mod path and load other files
mod_dir = ''..SMODS.current_mod.path
if (SMODS.Mods["Pokermon"] or {}).can_load then
    pokermon_config = SMODS.Mods["Pokermon"].config
end

--Load Sprites file
local sprite, load_error = SMODS.load_file("marcpokesprites.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  sprite()
end

--Load consumables
local pconsumables = NFS.getDirectoryItems(mod_dir.."consumables")

for _, file in ipairs(pconsumables) do
  sendDebugMessage ("The file is: "..file)
  local consumable, load_error = SMODS.load_file("consumables/"..file)
  if load_error then
    sendDebugMessage ("The error is: "..load_error)
  else
    local curr_consumable = consumable()
    if curr_consumable.init then curr_consumable:init() end
    
    for i, item in ipairs(curr_consumable.list) do
      if not (item.pokeball and not pokermon_config.pokeballs) then
        item.discovered = not pokermon_config.pokemon_discovery
        item.poke_custom_prefix = default_poke_custom_prefix
        SMODS.Consumable(item)
      end
    end
  end
end 

--Load stickers
local pseals = NFS.getDirectoryItems(mod_dir.."stickers")

for _, file in ipairs(pseals) do
  sendDebugMessage ("The file is: "..file)
  local sticker, load_error = SMODS.load_file("stickers/"..file)
  if load_error then
    sendDebugMessage ("The error is: "..load_error)
  else
    local curr_sticker = sticker()
    if curr_sticker.init then curr_sticker:init() end
    
    for i, item in ipairs(curr_sticker.list) do
      item.discovered = not pokermon_config.pokemon_discovery
      SMODS.Sticker(item)
    end
  end
end


--Load pokemon file
local pfiles = NFS.getDirectoryItems(mod_dir.."pokemon")

for _, file in ipairs(pfiles) do
  sendDebugMessage ("The file is: "..file)
  local pokemon, load_error = SMODS.load_file("pokemon/"..file)
  if load_error then
    sendDebugMessage ("The error is: "..load_error)
  else
    local curr_pokemon = pokemon()
    if curr_pokemon.init then curr_pokemon:init() end
    
    if curr_pokemon.list and #curr_pokemon.list > 0 then
      for i, item in ipairs(curr_pokemon.list) do
        if (pokermon_config.jokers_only and not item.joblacklist) or not pokermon_config.jokers_only  then
          item.discovered = true
          if not item.key then
            item.key = item.name
          end
          if not pokermon_config.no_evos and not item.custom_pool_func then
            item.in_pool = function(self)
              return pokemon_in_pool(self)
            end
          end
          if not item.config then
            item.config = {}
          end
          if item.ptype then
            if item.config and item.config.extra then
              item.config.extra.ptype = item.ptype
            elseif item.config then
              item.config.extra = {ptype = item.ptype}
            end
          end
          if item.item_req then
            if item.config and item.config.extra then
              item.config.extra.item_req = item.item_req
            elseif item.config then
              item.config.extra = {item_req = item.item_req}
            end
          end
          if item.evo_list then
            if item.config and item.config.extra then
              item.config.extra.evo_list = item.evo_list
            elseif item.config then
              item.config.extra = {item_req = item.evo_list}
            end
          end
          if pokermon_config.jokers_only and item.rarity == "poke_safari" then
            item.rarity = 3
          end
          item.poke_custom_prefix = default_poke_custom_prefix
          item.discovered = not pokermon_config.pokemon_discovery 
          SMODS.Joker(item)
        end
      end
    end
  end
end

local blinds = NFS.getDirectoryItems(mod_dir.."blinds")

for _, file in ipairs(blinds) do
  sendDebugMessage ("The file is: "..file)
  local blind, load_error = SMODS.load_file("blinds/"..file)
  if load_error then
    sendDebugMessage ("The error is: "..load_error)
  else
    local curr_blind = blind()
    if curr_blind.init then curr_blind:init() end
    
    for i, item in ipairs(curr_blind.list) do
      item.discovered = not pokermon_config.pokemon_discovery
      SMODS.Blind(item)
    end
  end
end

--Load challenges file
local pchallenges = NFS.getDirectoryItems(mod_dir.."challenges")

for _, file in ipairs(pchallenges) do
  local challenge, load_error = SMODS.load_file("challenges/"..file)
  if load_error then
    sendDebugMessage ("The error is: "..load_error)
  else
    local curr_challenge = challenge()
    if curr_challenge.init then curr_challenge:init() end
    
    for i, item in ipairs(curr_challenge.list) do
      SMODS.Challenge(item)
    end
  end
end 