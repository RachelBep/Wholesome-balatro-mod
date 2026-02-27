
Wholesome = SMODS.current_mod
Wholesome.Bane = SMODS.Center:extend {
  class_prefix = "bane",
  discovered = true,
  unlocked = true,
  set = "Bane",
  config = {},
  loc_txt = {},
  set_card_type_badge = function(self, card, badges)
      badges[#badges + 1] = create_badge(localize('who_Bane_badge'), G.C.BLACK, G.C.WHITE, 1.2)
  end,
  required_params = { "key", "atlas", "pos" },
  pre_inject_class = function(self)
      G.P_CENTER_POOLS[self.set] = {}
  end,
  inject = function(self)
      if not self.unlocked and self.check_for_unlock then
          if self:check_for_unlock() then
              self.unlocked = true
          end
      end
      SMODS.Center.inject(self)
  end,
  get_obj = function(self, key)
      if key == nil then
          return nil
      end
      return self.obj_table[key] or SMODS.Center:get_obj(key)
  end
}

SMODS.current_mod.custom_collection_tabs = function()
    return { UIBox_button {
        button = 'your_collection_Banes',
        id = 'your_collection_Wholesome_Banes',
        label = { 'Banes' },
        count = {
            tally = #G.P_CENTER_POOLS.Bane,
            of = #G.P_CENTER_POOLS.Bane
        },
        minw = 5
    } }
end

function G.FUNCS.your_collection_Banes()
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu {
      definition = SMODS.card_collection_UIBox(G.P_CENTER_POOLS.Bane, { 5, 5 }, {
          snap_back = true,
          infotip = localize('who_Bane_Collection_desc'),
          hide_single_page = true,
          collapse_single_page = true,
          h_mod = 0.65,
          modify_card = function(card, center, i, j)
              card.T.h = card.T.w
          end
      })
  }
end




function G.FUNCS.who_add_bane(type)
  local bane = create_card(nil, G.banes, nil, nil, nil, nil, type, nil)
  bane.states.click.can = false
  bane.T.w = .5*G.CARD_W
  bane.T.h = .5*G.CARD_W
  bane.pinned = true
  G.banes:emplace(bane)
end
function G.FUNCS.who_make_bane_off_screen()
  local bane = SMODS.create_card({
    set = "Bane",
    area = G.bane_bank,
    no_edition = true,
    allow_duplicates = true,
  })
  bane.T.w = .5*G.CARD_W
  bane.T.h = .5*G.CARD_W
  bane.states.click.can = false
  bane.states.drag.can = false
  G.bane_bank:emplace(bane)
  return bane
end

function G.FUNCS.who_get_bane_set() -- theres prolly a smarter way to do this but its 9 objects i can just do it by hand faster
    G.bane_bank.cards = {}
    G.GAME.who.round_reset_banes = {
    Small = {
      G.FUNCS.who_make_bane_off_screen(),
      G.FUNCS.who_make_bane_off_screen(),
      G.FUNCS.who_make_bane_off_screen()
    },
    Big = {
      G.FUNCS.who_make_bane_off_screen(),
      G.FUNCS.who_make_bane_off_screen(),
      G.FUNCS.who_make_bane_off_screen()
    },
    Boss = {
      G.FUNCS.who_make_bane_off_screen(),
      G.FUNCS.who_make_bane_off_screen(),
      G.FUNCS.who_make_bane_off_screen()
    }
  }
    G.GAME.who.round_reset_bane_value = {
    Small = {
      pseudorandom('bane', 1, 3),
      pseudorandom('bane', 1, 3)+3,
      pseudorandom('bane', 1, 3)+6
    },
    Big = {
      pseudorandom('bane', 1, 3),
      pseudorandom('bane', 1, 3)+3,
      pseudorandom('bane', 1, 3)+6
    },
    Boss = {
      pseudorandom('bane', 1, 3),
      pseudorandom('bane', 1, 3)+3,
      pseudorandom('bane', 1, 3)+6
    }
  }
end

function G.FUNCS.who_load_bane_set()
    G.GAME.who.round_reset_banes = {
    Small = {
      G.bane_bank.cards[1],
      G.bane_bank.cards[2],
      G.bane_bank.cards[3]
    },
    Big = {
      G.bane_bank.cards[4],
      G.bane_bank.cards[5],
      G.bane_bank.cards[6]
    },
    Boss = {
      G.bane_bank.cards[7],
      G.bane_bank.cards[8],
      G.bane_bank.cards[9]
    }
  }
end

function G.FUNCS.who_get_banes_from_set(values, set)
  set = set or {}
  local passed_banes = {}
  for i, v in pairs(set) do
    if values[i] <= G.GAME.who.curse then
      passed_banes[#passed_banes+1] = v
    end
  end
  return passed_banes
end

function G.FUNCS.who_add_curse(val)
  G.E_MANAGER:add_event(Event({
  func = function()

        local old_curse = G.GAME.who.curse
        local curse_UI = G.HUD:get_UIE_by_ID('hud_who_curse')
        local text = '+'
        local col = G.C.RED
        G.GAME.who.curse = math.max( math.min(G.GAME.who.curse + val, math.min(9, G.GAME.who.max_curse)), math.max(0, G.GAME.who.min_curse) )
        local change = G.GAME.who.curse - old_curse
        if change < 0 then
            text = '-'
            col = G.C.BLUE
        end
        if G.GAME.who.curse ~= old_curse then
          attention_text({
            text = text..tostring(math.abs(change)),
            scale = 0.8,
            hold = 0.7,
            cover = curse_UI,
            cover_colour = col,
            align = 'cm',
            })
            play_sound('crumple1') --i should look for a better sound effect for this
            if G.blind_select and G.hand.T.y and G.jokers.T.y and G.ROOM.T.y then
              local offsetti = G.blind_select.alignment.offset
              G.blind_prompt_box:remove()
              G.blind_select:remove()
              G.blind_select = UIBox{
                  definition = create_UIBox_blind_select(),
                  config = {align="bmi", offset = offsetti,major = G.hand, bond = 'Weak'}
              }
            end
        end

      return true
  end
  }))

end

function G.FUNCS.who_set_min_curse(val)
G.GAME.who.min_curse = math.max(math.min(val, G.GAME.who.max_curse), 0)
G.FUNCS.who_add_curse(0)
end

function G.FUNCS.who_set_max_curse(val)
G.GAME.who.max_curse = math.min(math.max(val, G.GAME.who.min_curse), 9)
G.FUNCS.who_add_curse(0)
end

assert(SMODS.load_file("items/card_addons.lua"))()
assert(SMODS.load_file("items/spectral.lua"))()
assert(SMODS.load_file("items/bane.lua"))()
assert(SMODS.load_file("items/vouchers.lua"))()
assert(SMODS.load_file("items/blinds.lua"))()
assert(SMODS.load_file("items/tarot.lua"))()
assert(SMODS.load_file("items/jokers.lua"))()
assert(SMODS.load_file("items/info_queue.lua"))()




G.FUNCS.upgrade_big_blind_button = function(e)
  if (G.GAME.used_vouchers["v_who_duplicated"] and not G.GAME.round_resets.big_upgraded) then
      e.config.colour = G.C.RED
      e.config.button = 'upgrade_big'
      e.children[1].children[1].config.shadow = true
      if e.children[2] then e.children[2].children[1].config.shadow = true end
  else
    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    e.config.button = nil
    e.children[1].children[1].config.shadow = false
    if e.children[2] then e.children[2].children[1].config.shadow = false end
  end
end


G.FUNCS.upgrade_big = function(e)
  stop_use()
  G.GAME.round_resets.big_upgraded = true
  G.CONTROLLER.locks.upgrade_big = true
  G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = function()
        play_sound('other1')
        G.blind_select_opts.big:set_role({xy_bond = 'Weak'})
        G.blind_select_opts.big.alignment.offset.y = 20
        return true
      end
    }))
  G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 0.3,
    func = (function()
      local par = G.blind_select_opts.big.parent
      G.GAME.round_resets.blind_choices.Big = get_new_boss()

      G.blind_select_opts.big:remove()
      local blind_ui =create_UIBox_blind_choice('Big')
      blind_ui.nodes[1].nodes[3].nodes[1].nodes[2].nodes[3].nodes[2].config.text = string.rep(localize("$"), G.P_BLINDS[G.GAME.round_resets.blind_choices['Big']].dollars*2)..'+'
      G.blind_select_opts.big = UIBox{
        T = {par.T.x, 0, 0, 0, },
        definition =
          {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
            UIBox_dyn_container({blind_ui},false,get_blind_main_colour('Big'), mix_colours(G.C.BLACK, get_blind_main_colour('Big'), 0.8))
          }},
        config = {align="bmi",
                  offset = {x=0,y=G.ROOM.T.y + 9},
                  major = par,
                  xy_bond = 'Weak'
                }
      }
      par.config.object = G.blind_select_opts.big
      par.config.object:recalculate()
      G.blind_select_opts.big.parent = par
      G.blind_select_opts.big.alignment.offset.y = 0

      G.E_MANAGER:add_event(Event({blocking = false, trigger = 'after', delay = 0.5,func = function()
          G.CONTROLLER.locks.upgrade_big = nil
          return true
        end
      }))

      save_run()
        return true
    end)
  }))
end

function Wholesome.get_enhancement_count(enh)
  local count = 0
  if G.hand then
    for i, card in pairs(G.hand.cards) do
      if SMODS.get_enhancements(card)[enh] then
        count = count + 1
      end
    end
  end
  return count
end

function Wholesome.get_consumable_count(id)
  local count = 0
  if G.consumeables then
    for i, card in pairs(G.consumeables.cards) do
      if card.config.center_key == id then
        count = count + 1
      end
    end
  end
  return count
end
