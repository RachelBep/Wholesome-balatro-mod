SMODS.Atlas {
  key = 'enhance',
  px = 71,
  py = 95,
  path = 'Enhancers.png'
}
SMODS.Enhancement {
  key = 'ethereal',
  atlas = 'enhance',
  pos = {x=1, y=1},
  unlocked = true,
  discovered = true,
  config = {x_chips = 1.5, x_mult = 1.5},
  loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.x_chips, card.ability.x_mult} }
	end,
  weight = 1,
}

local original_can_discard = G.FUNCS.can_discard
G.FUNCS.can_discard = function(e)
    original_can_discard(e)
    for key, card in pairs(G.hand.highlighted) do
        if SMODS.has_enhancement(card,'m_who_ethereal') then
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
            break
        end
    end
end
