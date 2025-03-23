assert(SMODS.load_file("functions/marcpokefunctions.lua"))()

default_poke_custom_prefix = "marcpoke"

SMODS.Atlas({
  key = "regionals",
  path = "Regionals.png",
  path_prefix = SMODS.Mods["Pokermon"].path,
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "shiny_regionals",
  path = "ShinyRegionals.png",
  path_prefix = SMODS.Mods["Pokermon"].path,
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "marcPoke1",
  path = "Pokedex1.png",
  path_prefix = SMODS.Mods["Pokermon"].path,
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "shiny_marcPoke1",
  path = "ShinyPokedex1.png",
  path_prefix = SMODS.Mods["Pokermon"].path,
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "marcPoke2",
  path = "Pokedex2.png",
  path_prefix = SMODS.Mods["Pokermon"].path,
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "shiny_marcPoke2",
  path = "Shinydex2.png",
  path_prefix = SMODS.Mods["Pokermon"].path,
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "marcPoke4",
  path = "Pokedex4.png",
  path_prefix = SMODS.Mods["Pokermon"].path,
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "shiny_marcPoke4",
  path = "Shinydex4.png",
  path_prefix = SMODS.Mods["Pokermon"].path,
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
    key = "marcPoke5",
    path = "Pokedex5.png",
    path_prefix = SMODS.Mods["Pokermon"].path,
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
  key = "shiny_marcPoke5",
  path = "Shinydex5.png",
  path_prefix = SMODS.Mods["Pokermon"].path,
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "marcPoke6",
  path = "Pokedex6.png",
  path_prefix = SMODS.Mods["Pokermon"].path,
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "shiny_marcPoke6",
  path = "Shinydex6.png",
  path_prefix = SMODS.Mods["Pokermon"].path,
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "marcPoke7",
  path = "Pokedex7.png",
  path_prefix = SMODS.Mods["Pokermon"].path,
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "shiny_marcPoke7",
  path = "Shinydex7.png",
  path_prefix = SMODS.Mods["Pokermon"].path,
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "marcPoke8",
  path = "Pokedex8.png",
  path_prefix = SMODS.Mods["Pokermon"].path,
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "shiny_marcPoke8",
  path = "Shinydex8.png",
  path_prefix = SMODS.Mods["Pokermon"].path,
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "luminous_cave",
  path = "LuminousCave.png",
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "shiny_luminous_cave",
  path = "LuminousCave.png",
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "bills_pc",
  path = "BillsPC.png",
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "shiny_bills_pc",
  path = "BillsPC.png",
  px = 71,
  py = 95
}):register()

SMODS.Atlas {
	key = "stickers",
	path = "stickers.png",
	px = 71,
	py = 95
}

--Required by the pokemon family function (right click on a pokemon joker)
table.insert(family, {"trubbish", "garbodor"})
table.insert(family, {"timburr", "gurdurr", "conkeldurr"})
table.insert(family, {"yungoos", "gumshoos"})
table.insert(family, {"alolan_grimer", "alolan_muk"})


table.insert(family, {"toxtricity"})
table.insert(family, {"chatot"})
table.insert(family, {"maractus"})
table.insert(family, {"cinderace"})
--table.insert(family, {"chikorita", "bayleef", "meganium"})


-- Get mod path and load other files
mod_dir = ''..SMODS.current_mod.path
if (SMODS.Mods["Pokermon"] or {}).can_load then
    pokermon_config = SMODS.Mods["Pokermon"].config
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