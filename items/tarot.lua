SMODS.Atlas {
  key = 'tarot',
  px = 71,
  py = 95,
  path = 'Tarots.png'
}

SMODS.Consumable {
  key = 'witch',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = true,
  discovered = true,
  cost = 3,
  in_pool = function(self,args)
    return (G.GAME.who.curse or 0) > 0
  end,
  loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.who.witch_rarity or 1, Wholesome.get_rarity_name(G.GAME.who.witch_rarity or 1) } } -- this would go sick with a colour changing depending on the rearity but i can figure out how to have vars edit the text styling
    end,
  can_use = function(self, card)
        if #G.jokers.highlighted == 1 and (G.jokers.highlighted[1].config.center.rarity or 0) >= G.GAME.who.witch_rarity and not SMODS.is_eternal(G.jokers.highlighted[1]) then
          return true
        end
        return false
    end,
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.75,
            func = function()
                G.jokers.highlighted[1]:start_dissolve(nil, _first_dissolve)
                G.FUNCS.who_add_curse(-1)
                if not ((G.GAME.who.witch_rarity + 1) >= #SMODS.Rarity.obj_buffer) then --if the current rarity is the 2nd last one then it stops
                  G.GAME.who.witch_rarity = G.GAME.who.witch_rarity + 1
                end
                return true
            end
        }))

  end,
  calculate = function(self, card, context)
    if context.after and G.GAME.used_vouchers["v_who_tarot_reading"] then
      for i, bane in pairs(G.banes.cards) do
        if SMODS.pseudorandom_probability(card, 'bane_gaming', 1, 3) then
              card:juice_up()
              bane:start_dissolve({ HEX("EA002E") }, nil, 1.6)

          end
      end
   end
  end,
}


function Wholesome.get_rarity_name(rarity)
  local unlocalized = SMODS.Rarities[SMODS.Rarity.obj_buffer[rarity]].key
 if localize(unlocalized) == 'ERROR' then
   return unlocalized
 else
   return localize(unlocalized)
 end
end
