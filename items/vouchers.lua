SMODS.Atlas {
  key = 'vouchers',
  px = 71,
  py = 95,
  path = 'Vouchers.png'
}


SMODS.Voucher {
  key = 'gilded_roots',
  atlas = 'vouchers',
  pos = { x=1, y = 3},
  unlocked = true,
  discovered = true,
  	in_pool = function(self,args)
      return not G.GAME.used_vouchers["v_money_tree"]
    end,
  requires = {'v_seed_money'},
config = { extra = { itrest = 1 } },
  loc_vars = function(self, info_queue, card)
		return { vars = { 5-card.ability.extra.itrest } }
	end,
  redeem = function(self,card)
    G.GAME.interest_divider = math.max(1, G.GAME.interest_divider-card.ability.extra.itrest)
  end,
}

SMODS.Voucher:take_ownership('v_money_tree',
{
  in_pool = function(self,args)
    return not G.GAME.used_vouchers["v_who_gilded_roots"]
  end,

}, true)

SMODS.Voucher {
  key = 'duplicated',
  atlas = 'vouchers',
  pos = {x=6, y=3},
  unlocked = true,
  discovered = true,
  requires = {'v_directors_cut'},
  calc_dollar_bonus = function(self, card)
        if G.GAME.blind_on_deck == 'Big' and G.GAME.blind:get_type() == 'Boss' then
          return G.GAME.blind.dollars or nil
        else
          return nil
        end
    end,
    in_pool = function(self,args)
      return not G.GAME.used_vouchers["v_retcon"]
    end,
}


SMODS.Voucher:take_ownership('v_retcon',
{
  in_pool = function(self,args)
    return not G.GAME.used_vouchers["v_who_duplicated"]
  end,

}, true)



SMODS.Voucher {
  key = 'tarot_fanatic',
  atlas = 'vouchers',
  pos = {x=1, y=1},
  unlocked = true,
  discovered = true,
  requires = {'v_tarot_merchant'},
  in_pool = function(self,args)
    return not G.GAME.used_vouchers["v_tarot_tycoon"]
  end,
  calculate = function(self, card, context)
    if context.starting_shop then

      SMODS.add_booster_to_shop(get_pack('shop_pack', 'Arcana').key)
   end
  end,
}

SMODS.Voucher:take_ownership('v_tarot_tycoon',
{
  in_pool = function(self,args)
    return not G.GAME.used_vouchers["v_who_tarot_fanatic"]
  end,
}, true)


SMODS.Voucher {
  key = 'planet_fanatic',
  atlas = 'vouchers',
  pos = {x=2, y=1},
  unlocked = true,
  discovered = true,
  requires = {'v_planet_merchant'},
  in_pool = function(self,args)
    return not G.GAME.used_vouchers["v_planet_tycoon"]
  end,
  calculate = function(self, card, context)
    if context.starting_shop then
      SMODS.add_booster_to_shop(get_pack('shop_pack', 'Celestial').key)
   end
  end,
}

SMODS.Voucher:take_ownership('v_planet_tycoon',
{
  in_pool = function(self,args)
    return not G.GAME.used_vouchers["v_who_planet_fanatic"]
  end,

}, true)

SMODS.Voucher {
  key = 'arborglyph',
  atlas = 'vouchers',
  pos = {x=5, y=3},
  unlocked = true,
  discovered = true,
  requires = {'v_hieroglyph'},
  config = { extra = { subtraction = 1 } },
  loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.subtraction } }
	end,
  redeem = function(self,card)
    G.GAME.win_ante = (G.GAME.win_ante or 8) - card.ability.extra.subtraction
  end,
  in_pool = function(self,args)
    return not (G.GAME.used_vouchers["v_petroglyph"] or G.GAME.round_resets.ante == G.GAME.win_ante) --it technically works on the last ante but i think its cheap
  end,
}

SMODS.Voucher:take_ownership('v_petroglyph',
{
  in_pool = function(self,args)
    return not G.GAME.used_vouchers["v_who_arborglyph"]
  end,
}, true)


SMODS.Voucher {
  key = 'mentalism',
  atlas = 'vouchers',
  pos = {x=4, y=3},
  unlocked = true,
  discovered = true,
  requires = {'v_magic_trick'},
  in_pool = function(self,args)
    return not G.GAME.used_vouchers["v_illusion"]
  end,
}

SMODS.Voucher:take_ownership('v_illusion',
{
  in_pool = function(self,args)
    return not G.GAME.used_vouchers["v_who_mentalism"]
  end,
}, true)


SMODS.Voucher {
  key = 'rover',
  atlas = 'vouchers',
  pos = {x=3, y=3},
  unlocked = true,
  discovered = true,
  requires = {'v_telescope'},
  in_pool = function(self,args)
    return not G.GAME.used_vouchers["v_observatory"]
  end,
  redeem = function(self,card)

    for i, hand in pairs(G.GAME.hands) do
      hand.l_mult = hand.l_mult * 2
      hand.l_chips = hand.l_chips * 2
    end
  end,
}

SMODS.Voucher:take_ownership('v_observatory',
{
  in_pool = function(self,args)
    return not G.GAME.used_vouchers["v_who_rover"]
  end,
}, true)

SMODS.Voucher {
  key = 'reroll_bulk',
  atlas = 'vouchers',
  pos = {x=0, y=3},
  unlocked = true,
  discovered = true,
  config = { extra = { current_rerolls = 0, needed_rerolls = 3, extra_cost = 1 } },
  loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.current_rerolls, card.ability.extra.needed_rerolls, card.ability.extra.extra_cost,} }
	end,
  requires = {'v_reroll_surplus'},
  in_pool = function(self,args)
    return not G.GAME.used_vouchers["v_reroll_glut"]
  end,
  calculate = function(self, card, context)
     if context.reroll_shop then
       self.config.extra.current_rerolls = 1 + (self.config.extra.current_rerolls or 0)
       if self.config.extra.current_rerolls >= self.config.extra.needed_rerolls then
         self.config.extra.current_rerolls = 0
         G.E_MANAGER:add_event(Event({
             trigger = 'immediate',
             func = function()
               for i = #G.shop_booster.cards,1, -1 do
                 local c = G.shop_booster:remove_card(G.shop_booster.cards[i])
                 c:remove()
                 c = nil
               end
               local used_packs_copy = G.GAME.current_round.used_packs
               for i, booster_slot in pairs(used_packs_copy) do
                  G.GAME.current_round.used_packs[i] = get_pack('shop_pack').key
                  local card = Card(G.shop_booster.T.x + G.shop_booster.T.w/2,
                  G.shop_booster.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[G.GAME.current_round.used_packs[i] ], {bypass_discovery_center = true, bypass_discovery_ui = true})
                  create_shop_card_ui(card, 'Booster', G.shop_booster)
                  card.ability.booster_pos = i
                  card:start_materialize()
                  G.shop_booster:emplace(card)
               end
               calculate_reroll_cost()

               return true
             end
        }))

       end
       G.GAME.who.bulk_reroll_text = ' (' .. self.config.extra.current_rerolls .. '/' .. self.config.extra.needed_rerolls .. ')'
     end
  end,
  redeem = function(self,card)
    G.GAME.who.bulk_reroll_text = ' (' .. self.config.extra.current_rerolls .. '/' .. self.config.extra.needed_rerolls .. ')'
  end,
}

SMODS.Voucher:take_ownership('v_reroll_glut',
{
  in_pool = function(self,args)
    return not G.GAME.used_vouchers["v_who_reroll_bulk"]
  end,
}, true)



SMODS.Voucher {
  key = 'crayons',
  atlas = 'vouchers',
  pos = {x=7, y=3},
  unlocked = true,
  discovered = true,
  config = { extra = { size = 5 } },
  loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.size } }
    end,
  requires = {'v_paint_brush'},
  in_pool = function(self,args)
    return not G.GAME.used_vouchers["v_palette"]
  end,
  calculate = function(self, card, context)
    if context.open_booster then
      G.hand:change_size(card.ability.extra.size)
   end
   if context.ending_booster then
      G.hand:change_size(-card.ability.extra.size)
   end
  end,
}

SMODS.Voucher:take_ownership('v_palette',
{
  in_pool = function(self,args)
    return not G.GAME.used_vouchers["v_who_crayons"]
  end,
}, true)

SMODS.Voucher {
  key = 'journal',
  atlas = 'vouchers',
  pos = { x=5, y = 1},
  unlocked = true,
  discovered = true,
  	in_pool = function(self,args)
      return not G.GAME.used_vouchers["v_nacho_tong"]
    end,
  requires = {'v_grabber'},
config = { extra = { bonus = 1 } },
  loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.bonus } }
	end,
  redeem = function(self,card)
    SMODS.change_play_limit(card.ability.extra.bonus)
  end,
}

SMODS.Voucher:take_ownership('v_nacho_tong',
{
  in_pool = function(self,args)
    return not G.GAME.used_vouchers["v_who_journal"]
  end,
}, true)

SMODS.Voucher {
  key = 'incineration',
  atlas = 'vouchers',
  pos = { x=6, y = 1},
  unlocked = true,
  discovered = true,
  	in_pool = function(self,args)
      return not G.GAME.used_vouchers["v_recyclomancy"]
    end,
  requires = {'v_wasteful'},
config = { extra = { bonus = 2 } },
  loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.bonus } }
	end,
  redeem = function(self,card)
    SMODS.change_discard_limit(card.ability.extra.bonus)
  end,
}

SMODS.Voucher:take_ownership('v_recyclomancy',
{
  in_pool = function(self,args)
    return not G.GAME.used_vouchers["v_who_incineration"]
  end,
}, true)

SMODS.Voucher {
  key = 'apophnia',
  atlas = 'vouchers',
  pos = { x=7, y = 1},
  unlocked = true,
  discovered = true,
  	in_pool = function(self,args)
      return not G.GAME.used_vouchers["v_antimatter"]
    end,
  requires = {'v_blank'},
config = { extra = { bonus = 2 } },
  loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.bonus } }
	end,
  redeem = function(self,card)
    G.E_MANAGER:add_event(Event({
            func = function()
                if G.jokers then
                    G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.bonus
                    if G.GAME.who.min_curse < G.GAME.round_resets.ante then
                      G.FUNCS.who_set_min_curse(G.GAME.round_resets.ante)
                    end
                end
                return true
            end,
        }))
  end,
  calculate = function(self, card, context)
    if context.who_change_ante and G.GAME.who.min_curse < G.GAME.round_resets.ante then
      G.E_MANAGER:add_event(Event({
      G.FUNCS.who_set_min_curse(G.GAME.round_resets.ante)
      }))
   end
  end,
}

SMODS.Voucher:take_ownership('v_antimatter',
{
  in_pool = function(self,args)
    return not G.GAME.used_vouchers["v_who_apophnia"]
  end,
}, true)



SMODS.Voucher { --please jesus NEVER do this
  key = 'tarot_reading',
  atlas = 'vouchers',
  pos = {x=2, y=3},
  unlocked = true,
  discovered = true,
  requires = {'v_crystal_ball'},
  config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
  		return { vars = { } }
  	end,
  in_pool = function(self,args)
    return not G.GAME.used_vouchers["v_omen_globe"]
  end,
  calculate = function(self, card, context)
    local returnargs = {}
    if context.debuff_card then
      if Wholesome.get_consumable_count('c_lovers') > 0 and SMODS.get_enhancements(context.debuff_card)['m_wild'] then
        return {prevent_debuff = true}
      end
    end -- end of debuff cards


    if context.other_consumeable then
      if context.other_consumeable.config.center_key == 'c_chariot' then
        return {
                x_mult = 1+ (0.1 * Wholesome.get_enhancement_count('m_steel')),
                message_card = context.other_consumeable
            }
      end
      if context.other_consumeable.config.center_key == 'c_tower' then
        return {
                chips = (math.ceil(hand_chips/50)*50) - hand_chips,
                message_card = context.other_consumeable
            }
      end
    end -- end of individual tarot card scoring
    for i, tarot in pairs(G.consumeables.cards) do
      if context.individual and context.cardarea == G.play then
        --magician
        if tarot.config.center_key == 'c_magician' and context.other_card.config.center_key == 'm_lucky' then
          if SMODS.pseudorandom_probability(card, 'lucky_mult', 1, 10) then

                context.other_card.lucky_trigger = true
                hand_chips = mod_chips(hand_chips + 50)
                tarot:juice_up()
                card_eval_status_text(context.other_card, 'chips', 50, percent, nil, nil)
                percent = percent+percent_delta

            end

        end
        -- (tarot.config.center_key == 'c_world' and context.other_card:is_suit('Spades'))
        if (tarot.config.center_key == 'c_star' and context.other_card:is_suit('Diamonds')) or (tarot.config.center_key == 'c_moon' and context.other_card:is_suit('Clubs')) or (tarot.config.center_key == 'c_sun' and context.other_card:is_suit('Hearts')) or (tarot.config.center_key == 'c_world' and context.other_card:is_suit('Spades')) then
                hand_chips = mod_chips(hand_chips + 25)
                tarot:juice_up()
                card_eval_status_text(context.other_card, 'chips', 25, percent, nil, nil)
                percent = percent+percent_delta



        end

      end --end of played cards
      if context.selling_card and tarot.config.center_key == 'c_judgement' and not returnargs.judgementprocced then
        if SMODS.pseudorandom_probability(card, 'joker_return', 1, 6) then
          returnargs.judgementprocced = true
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Joker' })
                tarot:juice_up(0.3, 0.5)
                return true
            end}))
        end
      end -- end of judgement
      if context.end_of_round and context.game_over == false and context.main_eval then
        if tarot.config.center_key == 'c_hermit' then
            tarot.ability.extra = tarot.ability.extra + 5
        end
        if tarot.config.center_key == 'c_strength' then
            tarot.ability.consumeable.max_highlighted = tarot.ability.consumeable.max_highlighted + 1
            tarot.ability.max_highlighted = tarot.ability.max_highlighted + 1
        end
        if tarot.config.center_key == 'c_hanged_man' then
          tarot.ability.consumeable.max_highlighted = tarot.ability.consumeable.max_highlighted + 1
          tarot.ability.max_highlighted = tarot.ability.max_highlighted + 1
        end
        if tarot.config.center_key == 'c_death' then
          tarot.ability.consumeable.max_highlighted = tarot.ability.consumeable.max_highlighted + 1
          tarot.ability.max_highlighted = tarot.ability.max_highlighted + 1
        end
        if tarot.config.center_key == 'c_temperance' then
            local selected_joker = pseudorandom_element(G.jokers.cards, 'temperance')
            selected_joker.ability.extra_value = (selected_joker.ability.extra_value or 0) + 2
            selected_joker:set_cost()
            selected_joker:juice_up()
        end
        if tarot.config.center_key == 'c_devil' then
            local gold_count = Wholesome.get_enhancement_count('m_gold')
            if gold_count > 0 then
              G.E_MANAGER:add_event(Event({
                  func = function()
                      tarot:juice_up()
                      ease_dollars(gold_count)
                      card_eval_status_text(tarot, 'dollars', gold_count, percent, nil, nil)
                      return true
                  end
              }))
            end
        end
        if tarot.config.center_key == 'c_wheel_of_fortune' then
            if SMODS.pseudorandom_probability(card, 'lucky_mult', 1, 6) then
              local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)

              local eligible_card = pseudorandom_element(editionless_jokers, 'passive_wheel_of_fortune')
              local edition = SMODS.poll_edition { key = "passive_wheel_of_fortune", guaranteed = true, no_negative = true, options = { 'e_polychrome', 'e_holo', 'e_foil' } }
              eligible_card:set_edition(edition, true)
              check_for_unlock({ type = 'have_edition' })
              tarot:start_dissolve({ HEX("EA002E") }, nil, 1.6)
            end
        end
      end -- end of end of round
      if context.repetition and context.cardarea == G.play and tarot.config.center_key == 'c_justice' and context.other_card.config.center_key == 'm_glass' then
            returnargs.repetitions = (returnargs.repetitions or 0) + 1
        end
      if context.destroy_card and context.cardarea == G.play and tarot.config.center_key == 'c_justice' and context.destroy_card.config.center_key == 'm_glass' and
            SMODS.pseudorandom_probability(context.destroy_card, 'justice_trolling', 1, 4) then
            card.glass_trigger = true -- SMODS addition
            return { remove = true }
        end
      if context.before then
        if tarot.config.center_key == 'c_empress' then
          for _, scored_card in ipairs(context.scoring_hand) do
                if SMODS.get_enhancements(scored_card)['m_mult'] and not scored_card.debuff then
                    scored_card:set_ability('c_base', nil, true)
                    scored_card.ability.perma_mult = scored_card.ability.perma_mult + 4
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            scored_card.vampired = nil
                            return true
                        end
                    }))
                end
          end
        end
          if tarot.config.center_key == 'c_heirophant' then
            for _, scored_card in ipairs(context.scoring_hand) do
                  if SMODS.get_enhancements(scored_card)['m_bonus'] and not scored_card.debuff then
                      scored_card:set_ability('c_base', nil, true)
                      scored_card.ability.perma_chips = scored_card.ability.perma_chips + 30
                      G.E_MANAGER:add_event(Event({
                          func = function()
                              scored_card:juice_up()
                              scored_card.vampired = nil
                              return true
                          end
                      }))
                  end
            end
          end

      end -- end of context before


    end --end of for tarots
    if next(returnargs) then
      return returnargs
    end
  end,
}


SMODS.Voucher:take_ownership('v_omen_globe',
{
  in_pool = function(self,args)
    return not G.GAME.used_vouchers["v_who_tarot_reading"]
  end,
}, true)

SMODS.Voucher {
  key = 'premium_stock',
  atlas = 'vouchers',
  pos = { x=0, y = 1},
  unlocked = true,
  discovered = true,
  	in_pool = function(self,args)
      return G.GAME.round_resets.ante < G.GAME.win_ante and not G.GAME.used_vouchers["v_overstock_plus"]
    end,
    redeem = function(self,card)
      card.ability.extra.ante= pseudorandom('ante', G.GAME.round_resets.ante, G.GAME.win_ante)
        if not card.ability.extra.ante == G.GAME.round_resets.ante then
          card.ability.extra.shop = pseudorandom_element({'Boss', 'Small', 'Big'}, 'blind')
        elseif Wholesome.get_current_shop() == 'Boss' then --if we're in the boss shop it can be in the small or big shop, if we're in the small shop it has to be big and if we're in the big shop it has to be next ante
          card.ability.extra.shop = pseudorandom_element({'Small', 'Big'}, 'blind')
        elseif Wholesome.get_current_shop() == 'Small' then
          card.ability.extra.shop = 'Big'
        else
          card.ability.extra.shop = pseudorandom_element({'Boss', 'Small', 'Big'}, 'blind')
          card.ability.extra.ante= card.ability.extra.ante + 1
        end
    end,
  requires = {'v_overstock'},
config = { extra = { ante = -99, shop = 'Small' } },
  loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.bonus } }
	end,
  calculate = function(self, card, context)
    if context.starting_shop then
       if Wholesome.get_current_shop() == card.ability.extra.shop and G.GAME.round_resets.ante == card.ability.extra.ante then
          local legendary = SMODS.add_card({ set = 'Joker', legendary = true, area = G.shop_jokers })
          create_shop_card_ui(legendary, 'Joker', G.shop_jokers)
          uno = G.shop_jokers.cards[1]
          G.shop_jokers:remove_card(uno)
          SMODS.destroy_cards(uno, true, true, true)
       end
   end
  end,

}


function Wholesome.get_current_shop() --no promises this will be correct while not in the shop
  local bod = G.GAME.blind_on_deck
  if bod == 'Big' then
    return bod -- when its big it works just fine
  elseif G.GAME.round_resets.blind_states[bod] == 'Defeated' then
    return bod
  else -- if you are on small blind and you havnt defeated it then you are on the boss blind shop
    return 'Boss'
  end

end

SMODS.Voucher:take_ownership('v_overstock_plus',
{
  in_pool = function(self,args)
    return not G.GAME.used_vouchers["v_who_premium_stock"]
  end,
}, true)
