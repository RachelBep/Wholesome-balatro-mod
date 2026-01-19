SMODS.Atlas {
  key = 'joker',
  px = 71,
  py = 95,
  path = 'Jokers.png'
}

SMODS.Joker {
  key = 'shady_deals',
  atlas = 'joker',
  pos = { x=0, y = 0},
  unlocked = true,
  discovered = true,
  rarity = 2,
  cost = 5,
config = { extra = { unsale = 0, selected_last_frame = false } },
  update = function(self, card, dt)
    if card.parent == G.jokers then
      if not card.ability.extra.selected_last_frame and card.highlighted then
          card.ability.extra.selected_last_frame = true
          card.ability.extra.unsale = 100 - G.GAME.discount_percent
          G.GAME.discount_percent = 100
          for _, v in pairs(G.I.CARD) do
                      if v.set_cost then v:set_cost() end
                  end
      end
      if card.ability.extra.selected_last_frame and not card.highlighted then
        card.ability.extra.selected_last_frame = false
        G.GAME.discount_percent = G.GAME.discount_percent - card.ability.extra.unsale
        card.ability.extra.unsale = 0
        for _, v in pairs(G.I.CARD) do
                      if v.set_cost then v:set_cost() end
                  end
      end
    end


  end,
  remove_from_deck = function(self, card, from_debuff)
    card.ability.extra.selected_last_frame = false
    G.GAME.discount_percent = G.GAME.discount_percent - card.ability.extra.unsale
    card.ability.extra.unsale = 0
    for _, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end

  end,
  calculate = function(self, card, context)
      if (context.buying_card or (context.open_booster and context.card.children["buy_button"])) and card.ability.extra.unsale ~= 0 then
        G.FUNCS.who_add_curse(1)
      end
  end,
}
