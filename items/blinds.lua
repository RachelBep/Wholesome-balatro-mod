SMODS.Atlas {
  key = 'blinds',
  px = 34,
  py = 34,
  atlas_table = 'ANIMATION_ATLAS',
  frames = 21,
  path = 'BlindChips.png'
}

SMODS.Blind {
  key = "nullified",
  atlas = 'blinds',
  pos = {x=0, y=0},
  dollars = 5,
  boss_colour = HEX('494949'),
  no_collection = true,
  mult = 2,
  boss = {min = 128, max = 256}
}
