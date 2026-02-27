SMODS.Atlas {
  key = 'spectral',
  px = 71,
  py = 95,
  path = 'Spectrals.png'
}


SMODS.Consumable {
  key = 'spectre',
  set = 'Spectral',
  atlas = 'spectral',
  pos = {x=0, y=0},
  unlocked = true,
  discovered = true,
  cost = 4,
  config = {mod_conv = 'm_who_ethereal'},
  loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
    end,
  can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,
  use = function(self, card, area, copier)
    local to_enhance = {}

    for _, playing_card in pairs(G.hand.cards) do
      if playing_card.ability.name ~= 'Default Base' then to_enhance[#to_enhance+1] = playing_card end
    end

    G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #to_enhance do
            local percent = 1.15 - (i - 0.999) / (#to_enhance - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    to_enhance[i]:flip()
                    play_sound('card1', percent)
                    to_enhance[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #to_enhance do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    to_enhance[i]:set_ability(G.P_CENTERS[card.ability.mod_conv])
                    return true
                end
            }))
        end
        for i = 1, #to_enhance do
            local percent = 0.85 + (i - 0.999) / (#to_enhance - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    to_enhance[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    to_enhance[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.5)



  end,
}

SMODS.Consumable {
  key = 'slate',
  set = 'Spectral',
  atlas = 'spectral',
  pos = {x=2, y=0},
  unlocked = true,
  discovered = true,
  cost = 4,
  config = {blind_conv = 'bl_who_nullified'},
  loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_BLINDS[card.ability.blind_conv]
        return { vars = {  } }
    end,
    in_pool = function(self,args)
      if G.GAME.round_resets.ante % G.GAME.win_ante == 0 then
          return false
      else
          return true
      end
    end,
  can_use = function(self, card)
        return true
    end,
  use = function(self, card, area, copier)
    G.FUNCS.who_add_curse(1)
    G.GAME.round_resets.blind_choices.Boss = card.ability.blind_conv
      if G.GAME.round_resets.blind_states['Boss'] == 'Current' then --it sets the text which is werid cuz idk how this is handled with translations and all that
        G.GAME.blind:disable()
        G.GAME.round_resets.blind = G.P_BLINDS[card.ability.blind_conv]
        G.GAME.blind:set_blind(G.GAME.round_resets.blind)
        ease_background_colour_blind()
      elseif G.blind_select then
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
              play_sound('other1') --important
              G.blind_select_opts.boss:set_role({xy_bond = 'Weak'}) --important
              G.blind_select_opts.boss.alignment.offset.y = 20 --important
              return true
            end
          }))
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.3,
            func = (function()
              local par = G.blind_select_opts.boss.parent

              G.blind_select_opts.boss:remove()
              G.blind_select_opts.boss = UIBox{
                T = {par.T.x, 0, 0, 0, },
                definition =
                  {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
                    UIBox_dyn_container({create_UIBox_blind_choice('Boss')},false,get_blind_main_colour('Boss'), mix_colours(G.C.BLACK, get_blind_main_colour('Boss'), 0.8))
                  }},
                config = {align="bmi",
                          offset = {x=0,y=G.ROOM.T.y + 9},
                          major = par,
                          xy_bond = 'Weak'
                        }
              }
              par.config.object = G.blind_select_opts.boss
              par.config.object:recalculate()
              G.blind_select_opts.boss.parent = par
              G.blind_select_opts.boss.alignment.offset.y = 0

              save_run()
                return true
            end)
          }))




      end
  end,
}

SMODS.Consumable {
  key = 'bound',
  set = 'Spectral',
  atlas = 'spectral',
  pos = {x=3, y=0},
  unlocked = true,
  discovered = true,
  cost = 4,
  can_use = function(self, card)
        local card_limit = #G.jokers.cards < G.jokers.config.card_limit or card.area == G.jokers
        local curse_limit = G.GAME.who.curse < G.GAME.who.max_curse
        return card_limit and curse_limit
    end,
  use = function(self, card, area, copier)

    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
          G.FUNCS.who_add_curse(1)

          local used_cards = {}
          local max_amt = 0
          for k, v in pairs(G.PROFILES[G.SETTINGS.profile]["joker_usage"]) do
            if G.P_CENTERS[k] and (not "Joker" or G.P_CENTERS[k].set == "Joker") and G.P_CENTERS[k].discovered then
              used_cards[#used_cards + 1] = {count = v.count, key = k}
              if v.count > max_amt then max_amt = v.count end
            end
          end

          table.sort(used_cards, function (a, b) return a.count > b.count end )

          local top_ten = {}
          for i = 1, 10 do
            top_ten[i] = used_cards[i]
          end

          local cool_card = SMODS.add_card({area=G.jokers, key = pseudorandom_element(top_ten, pseudoseed('joker')).key, edition = poll_edition(nil, nil, nil, true, nil)})
          cool_card:juice_up(0.3, 0.5)
          return true
        end
      }))

  end,
}
