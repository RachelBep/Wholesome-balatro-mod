SMODS.Atlas {
  key = 'bane',
  px = 34,
  py = 34,
  path = 'banes.png'
}


Wholesome.Bane {
    key = 'radio',
    atlas = 'bane',
    pos = {x=0, y=0},
    config = { extra = { xmult = 0.85 } },
    loc_vars = function(self, info_queue, card)
  		return { vars = { card.ability.extra.xmult } }
  	end,
    calculate = function(self, card, context)
  	   if context.joker_main then
         return {
                xmult = card.ability.extra.xmult
            }
       end
    end,
}

Wholesome.Bane {
    key = 'isaz',
    atlas = 'bane',
    pos = {x=1, y=0},
    config = { extra = { discards = -1 } },
    loc_vars = function(self, info_queue, card)
  		return { vars = { card.ability.extra.discards } }
  	end,
    calculate = function(self, card, context)
  	   if context.setting_blind then
         G.E_MANAGER:add_event(Event({
                func = function()
                    ease_discard(card.ability.extra.discards, nil, true)
                    return true
                end
            }))
            return nil, true
       end
    end,
}

Wholesome.Bane {
    key = 'ansuz',
    atlas = 'bane',
    pos = {x=2, y=0},
    config = { extra = { multiplier = 1.35 } },
    loc_vars = function(self, info_queue, card)
  		return { vars = { card.ability.extra.multiplier } }
  	end,
    calculate = function(self, card, context)
  	   if context.setting_blind then
         G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.multiplier
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    return true
                end
            }))
            return {
                        message = localize('who_ansuz_msg'),
                        colour = G.C.RED
                    }
       end
    end,
}

Wholesome.Bane {
    key = 'dagaz',
    atlas = 'bane',
    pos = {x=3, y=0},
    config = { extra = { multiplier = 0.65 } },
    loc_vars = function(self, info_queue, card)
  		return { vars = { card.ability.extra.multiplier } }
  	end,
    calculate = function(self, card, context)
      if context.modify_hand then
               mult = mod_mult(math.max(mult * card.ability.extra.multiplier, 1))
               update_hand_text({ sound = 'chips2', modded = true }, { mult = mult })
           end
    end,
}

Wholesome.Bane {
    key = 'thurs',
    atlas = 'bane',
    pos = {x=4, y=0},
    config = { extra = { card_type = "[Type]", suit = "[Suit]" } },
    loc_vars = function(self, info_queue, card)
  		return { vars = { card.ability.extra.card_type, card.ability.extra.suit } }
  	end,
    set_ability = function(self, card, initial, delay_sprites)
        local types = {"Face", "Even", "Odd"}
        card.ability.extra.card_type = types[pseudorandom('thurs', 1, #types)]
        card.ability.extra.suit = pseudorandom_element(SMODS.Suits, pseudoseed('myrank')).key
    end,
    calculate = function(self, card, context)
      if context.stay_flipped then -- i hate doing this in the stay flipped context but the actual debuff one is fucked to shit for some reason
            if context.other_card:is_suit(card.ability.extra.suit) then
              if card.ability.extra.card_type == "Face" then
                  if context.other_card:is_face() then context.other_card.debuff = true end
              elseif card.ability.extra.card_type == "Even" then
                  if context.other_card:get_id() <= 10 and context.other_card:get_id() >= 0 and context.other_card:get_id() % 2 == 0 then context.other_card.debuff = true end
              else
                if (context.other_card:get_id() <= 10 and context.other_card:get_id() >= 0 and context.other_card:get_id() % 2 == 1) or (context.other_card:get_id() == 14) then context.other_card.debuff = true end --with the fact that stemodded has custom ranks im shocked there isnt an is_even is_odd function
              end

            end
      end
    end,
}

Wholesome.Bane {
    key = 'gebo',
    atlas = 'bane',
    pos = {x=5, y=0},
    config = { extra = { enhancement = "m_stone"} },
    loc_vars = function(self, info_queue, card)
  		return { vars = {  localize({type = 'name_text', set = 'Enhanced', key = card.ability.extra.enhancement }) } }
  	end,
    set_ability = function(self, card, initial, delay_sprites)
      card.ability.extra.enhancement = pseudorandom_element(G.P_CENTER_POOLS.Enhanced, pseudoseed('enhance')).key
        if G.playing_cards then
          local valid_playing_cards = {}
          for _, playing_card in pairs(G.playing_cards) do
            if playing_card.ability.set ~= 'Default' then
              valid_playing_cards[#valid_playing_cards+1] = playing_card.config.center_key
            end
          end
          if #valid_playing_cards > 0 then
            card.ability.extra.enhancement = pseudorandom_element(valid_playing_cards, pseudoseed('enhance'))
          end
        end

    end,
    calculate = function(self, card, context)
      if context.stay_flipped then
            if SMODS.has_enhancement(context.other_card, card.ability.extra.enhancement) then
              return {
                    stay_flipped = true
                }
            end
      end
    end,
}
