SMODS.Atlas {
  key = 'tarot',
  px = 71,
  py = 95,
  path = 'Tarots.png'
}

SMODS.Consumable {
  key = 'info_fool',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  in_pool = function(self,args)
    return false
  end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}

SMODS.Consumable {
  key = 'info_magician',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  in_pool = function(self,args)
    return false
  end,
  config = { extra = { numerator = 1, demoninator = 10, chips = 50 } },
    loc_vars = function(self, info_queue, card)
      local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.demoninator, 'lucky') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
      return {vars = {new_numerator, new_denominator, card.ability.extra.chips}}
  	end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}

SMODS.Consumable {
  key = 'info_high_priestess',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  in_pool = function(self,args)
    return false
  end,
  config = { extra = { bonus = 1 } },
    loc_vars = function(self, info_queue, card)
      return {vars = {card.ability.extra.bonus}}
  	end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}

SMODS.Consumable {
  key = 'info_empress',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  in_pool = function(self,args)
    return false
  end,
  config = { extra = { mult = 4 } },
    loc_vars = function(self, info_queue, card)
      return {vars = {card.ability.extra.mult}}
  	end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}

SMODS.Consumable {
  key = 'info_emperor',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  in_pool = function(self,args)
    return false
  end,
  config = { extra = { bonus = 1 } },
    loc_vars = function(self, info_queue, card)
      return {vars = {card.ability.extra.bonus}}
  	end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}

SMODS.Consumable {
  key = 'info_hierophant',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  in_pool = function(self,args)
    return false
  end,
  config = { extra = { bonus = 30 } },
    loc_vars = function(self, info_queue, card)
      return {vars = {card.ability.extra.bonus}}
  	end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}

SMODS.Consumable {
  key = 'info_lovers',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  in_pool = function(self,args)
    return false
  end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}

SMODS.Consumable {
  key = 'info_chariot',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  in_pool = function(self,args)
    return false
  end,
  config = { extra = { bonus = .1 } },
    loc_vars = function(self, info_queue, card)
      return {vars = {card.ability.extra.bonus, 1+ (card.ability.extra.bonus * Wholesome.get_enhancement_count('m_steel'))}}
  	end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}





SMODS.Consumable {
  key = 'info_justice',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  in_pool = function(self,args)
    return false
  end,
  config = { extra = { numerator = 1, demoninator = 4, mult = 2 } },
    loc_vars = function(self, info_queue, card)
      local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.demoninator, 'ass') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
      return {vars = {new_numerator, new_denominator, card.ability.extra.mult}}
  	end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}

SMODS.Consumable {
  key = 'info_hermit',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  in_pool = function(self,args)
    return false
  end,
  config = { extra = { bonus = 5 } },
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.bonus}}
  	end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}

SMODS.Consumable {
  key = 'info_wheel_of_fortune',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  in_pool = function(self,args)
    return false
  end,
  config = { extra = { numerator = 1, demoninator = 6 } },
    loc_vars = function(self, info_queue, card)
      local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.demoninator, 'ass') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
      return {vars = {new_numerator, new_denominator}}
  	end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}

SMODS.Consumable {
  key = 'info_strength',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  in_pool = function(self,args)
    return false
  end,
  config = { extra = { bonus = 1 } },
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.bonus}}
  	end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}

SMODS.Consumable {
  key = 'info_hanged_man',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  in_pool = function(self,args)
    return false
  end,
  config = { extra = { bonus = 1 } },
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.bonus}}
  	end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}

SMODS.Consumable {
  key = 'info_death',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  in_pool = function(self,args)
    return false
  end,
  config = { extra = { bonus = 1 } },
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.bonus}}
  	end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}

SMODS.Consumable {
  key = 'info_temperance',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  in_pool = function(self,args)
    return false
  end,
  config = { extra = { bonus = 2 } },
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.bonus}}
  	end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}

SMODS.Consumable {
  key = 'info_devil',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  in_pool = function(self,args)
    return false
  end,
  config = { extra = { bonus = 1 } },
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.bonus, (card.ability.extra.bonus * Wholesome.get_enhancement_count('m_gold'))}}
  	end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}

SMODS.Consumable {
  key = 'info_tower',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  config = { extra = { bonus = 50 } },
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.bonus}}
  	end,
  in_pool = function(self,args)
    return false
  end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}

SMODS.Consumable {
  key = 'info_stars',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  in_pool = function(self,args)
    return false
  end,
  config = { extra = { bonus = 25 } },
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.bonus}}
  	end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}

SMODS.Consumable {
  key = 'info_moon',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  in_pool = function(self,args)
    return false
  end,
  config = { extra = { bonus = 25 } },
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.bonus}}
  	end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}

SMODS.Consumable {
  key = 'info_sun',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  in_pool = function(self,args)
    return false
  end,
  config = { extra = { bonus = 25 } },
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.bonus}}
  	end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}

SMODS.Consumable {
  key = 'info_judgement',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  in_pool = function(self,args)
    return false
  end,
  config = { extra = { numerator = 1, demoninator = 6 } },
    loc_vars = function(self, info_queue, card)
      local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.demoninator, 'ass') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
      return {vars = {new_numerator, new_denominator}}
  	end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}

SMODS.Consumable {
  key = 'info_world',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  in_pool = function(self,args)
    return false
  end,
  config = { extra = { bonus = 25 } },
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.bonus}}
  	end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}

SMODS.Consumable {
  key = 'info_witch',
  set = 'Tarot',
  atlas = 'tarot',
  pos = {x=0, y=0},
  unlocked = false,
  discovered = false,
  cost = 3,
  in_pool = function(self,args)
    return false
  end,
  config = { extra = { numerator = 1, demoninator = 3 } },
    loc_vars = function(self, info_queue, card)
      local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.demoninator, 'ass') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
      return {vars = {new_numerator, new_denominator}}
  	end,
  can_use = function(self, card)
        return false
    end,
  use = function(self, card, area, copier)
  end,
  no_collection = true,
}
