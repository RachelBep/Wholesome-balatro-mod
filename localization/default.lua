return {
  descriptions = {
    Edition = {
      e_who_dreamy = { name = 'Nullified', text = { '{C:inactive}Does nothing?'} },
    },
    Blind = {
      bl_who_nullified = { name = 'Nullified', text = { '{C:inactive}Does nothing?'} },
    },
    Spectral = {
      c_who_spectre = { name = 'Spectre', text = { 'Enhances {C:attention}all Enhanced cards{} in hand', 'to {C:attention}Ethereal Cards{}'} },
      c_who_slate = { name = 'Slate', text = { '{C:attention}Nullify{} Boss Blind', '{C:red}+1 curse{}'} },
      c_who_bound = { name = 'Bound', text = { '{C:red}+1 curse{} to create an', 'editioned instance of a joker', "from your most used jokers", "{C:inactive}(Must have room)",} },
    },
    Tarot = {
      c_who_witch = { name = 'The Witch', text = { 'Destroy selected #2# or rarer Joker', '{C:attention}-1{} Curse.' } },


      c_who_info_fool = { name = 'Passive ability', text = { "{C:inactive}Does nothing?" } },
      c_who_info_magician = { name = 'Passive ability', text = { 'Lucky cards have a','{C:green}#1# in #2#{}',' chance to','give {C:chips}+#3#{} Chips' } },
      c_who_info_high_priestess = { name = 'Passive ability', text = { '{C:planet}Celestial packs{} offer', '{C:important}#1#{} additional card' } },
      c_who_info_empress = { name = 'Passive ability', text = { 'Played {C:mult}Mult{} cards lose their', '{C:enhanced}Enhancement{} and gain {C:mult}+#1# Mult{}' } },
      c_who_info_emperor = { name = 'Passive ability', text = { '{C:tarot}Arcana packs{} offer', '{C:important}#1#{} additional card' } },
      c_who_info_hierophant = { name = 'Passive ability', text = { 'played {C:chips}Bonus{} cards lose their', '{C:enhanced}Enhancement{} and gain {C:chips}+#1# Chips{}' } },
      c_who_info_lovers = { name = 'Passive ability', text = { 'Wild cards cannot be debuffed' } },
      c_who_info_chariot = { name = 'Passive ability', text = { '{X:red,C:white} X#1#{} Mult for each','steel card in hand', '{C:inactive}(Currently {X:red,C:white} X#2# {C:inactive})' } },
      c_who_info_justice = { name = 'Passive ability', text = { 'Retrigger all played Glass Cards', 'Glass Cards have an additional','{C:green}#1# in #2#{} chance to be destroyed' } },
      c_who_info_hermit = { name = 'Passive ability', text = { 'Increase the max {C:money}${} given by this card','by {C:money}#1#${} at the end of round' } },
      c_who_info_wheel_of_fortune = { name = 'Passive ability', text = { 'At the end of round {C:green}#1# in #2#{} chance to add','{C:dark_edition}Foil, Holographic, or Polychrome{}','edition to a random joker','{C:red}destroys self{}' } },
      c_who_info_strength = { name = 'Passive ability', text = { 'At the end of each round increase','max selected cards on this by {C:attention}#1#{}' } },
      c_who_info_hanged_man = { name = 'Passive ability', text = { 'At the end of each round increase','max selected cards on this by {C:attention}#1#{}' } },
      c_who_info_death = { name = 'Passive ability', text = { 'At the end of each round increase','max selected cards on this by {C:attention}#1#{}' } },
      c_who_info_temperance = { name = 'Passive ability', text = { 'At the end of each round a random','joker gains {C:money}#1#${} sell value' } },
      c_who_info_devil = { name = 'Passive ability', text = { 'Gives {C:money}#1#${} per Gold Card held','in hand at the end of round', '{C:inactive}(Currently #2#$ {C:inactive})' } },
      c_who_info_tower = { name = 'Passive ability', text = { 'Rounds {C:chips}Chips{} to the next #1#' } },
      c_who_info_stars = { name = 'Passive ability', text = { '{C:diamonds}Diamond{} suit cards','give {C:chips}+#1# Chips{} when scored' } },
      c_who_info_moon = { name = 'Passive ability', text = { '{C:clubs}Club{} suit cards','give {C:chips}+#1# Chips{} when scored' } },
      c_who_info_sun = { name = 'Passive ability', text = { '{C:hearts}Heart{} suit cards','give {C:chips}+#1# Chips{} when scored' } },
      c_who_info_judgement = { name = 'Passive ability', text = { 'When a joker is sold {C:green}#1# in #2#{}','chance to create a random joker', '{C:inactive}(Must have room)' } },
      c_who_info_world = { name = 'Passive ability', text = { '{C:spades}Spade{} suit cards','give {C:chips}+#1# Chips{} when scored' } },
      c_who_info_witch = { name = 'Passive ability', text = { '{C:green}#1# in #2#{} chance to ',' destroy a random bane per hand' } },
    },
    Joker = {
      j_who_shady_deals = { name = 'Shade-E-E Joker', text = { 'While this is highlighted shop', 'items cost {C:money}1${} but purchasing a', 'shop item gives {C:red}+1 curse{}' } },
    },
    Voucher = {
      v_who_journal = { name = 'The Journal', text = { 'You may play {C:attention}#1#{} additional card', 'per {C:blue}hand{}'} },
      v_who_incineration = { name = 'Incineration', text = { 'You may discard {C:attention}#1#{} additional card', 'per {C:red}discard{}'} },
      v_who_duplicated = { name = 'Duplicated', text = { 'Upgrade Big Blind to Boss Blind', '{C:attention}1{} time per Ante', 'double its {C:money}${} reward'} },
      v_who_tarot_fanatic = { name = 'Tarot Fanatic', text = { 'Add an extra', '{C:tarot}Arcana Pack{} to', 'each {C:attention}shop{}'} },
      v_who_arborglyph = { name = 'Arborglyph', text = { '{C:attention}-#1#{} Win Ante'} },
      v_who_crayons = { name = 'Crayons', text = { '{C:attention}+#1#{} hand size in booster packs'} },
      v_who_reroll_bulk = { name = 'Reroll Bulk', text = { 'Every #2#rd reroll, reroll', 'booster packs and increase', 'reroll cost by {C:money}#3#$'} },
      v_who_rover = { name = 'Rover', text = { '{C:attention}Doubles{} {C:chips}Chips{} and {C:mult}Mult{} from hand level ups'} },
      v_who_mentalism = { name = 'Mentalism', text = { '{C:attention}Playing cards{} in shop may', 'appear with {C:chips}+30{} Chips, {C:mult}+4{} Mult,', 'or {X:mult,C:white}X1.15{} Mult'} },
      v_who_planet_fanatic = { name = 'Planet Fanatic', text = { 'Add an extra', '{C:planet}Celestial Pack{} to', 'each {C:attention}shop{}'} },
      v_who_gilded_roots = { name = 'Gilded Roots', text = { 'Gain {C:money}$1{} of', '{C:money}Interest{} per {C:money}$#1#{}', 'you have at the', 'end of round'} },
      v_who_apophnia = { name = 'Apophnia', text = { '{C:dark_edition}+#1#{} Joker Slots,', '{C:red}your curse cannot be lower{}', '{C:red}than your ante{}'} },
      v_who_overstock_minus = { name = 'Overstock Minus', text = { '{C:attention}+#1#{} card slots available in initial shop', "{C:inactive}(Before rerolls)"} },
      v_who_tarot_reading = { name = 'Tarot Reading', text = { 'Tarot cards give passive abilities',' while in your consumable area'} },
      v_who_premium_stock = { name = 'Premium Stock', text = { 'A future shop will contain','a {C:legendary,E:1}Legendary{} Joker','{C:inactive}(Dont miss it)'} },
    },
    Bane = {
      bane_who_radio = { name = 'Raidō', text = { '{X:mult,C:white}X#1#{} {C:mult}Mult{}'} },
      bane_who_isaz = { name = 'īsaz', text = { '{C:red}#1#{} discard'} },
      bane_who_ansuz = { name = 'Ansuz', text = { '{C:attention}#1#X{} blind size'} },
      bane_who_dagaz = { name = 'Dagaz', text = { '{C:attention}#1#X{} base Mult'} },
      bane_who_thurs = { name = 'Þurisaz', text = { '{C:attention}#1# #2#{} cards are debuffed'} },
      bane_who_gebo = { name = 'Gebō', text = { 'each {C:attention}#1#{} is drawn face down'} },
    },
    Enhanced={
      m_who_ethereal = { name = 'Ethereal Card', text = {'{X:chips,C:white}X#1#{} Chips {X:mult,C:white}X#2#{} Mult', '{C:red}must be selected{}, always scores'} },
    }
  },
  misc = {
    dictionary = {
      who_Bane_badge = "Bane",
      who_Bane_Collection_desc = {'Banes can be applied to blinds if your', 'curse gets too high in a run.'},
      who_blind_select_banes = "Banes:",
      who_ansuz_msg = "Fall",
    }
  }
}
