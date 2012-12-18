#<< item
item "Banner of Command",
  code: 3060

  ap: 50
  armor: 30

  cost: 890
  sell: 1680

  recipe: ["Blasting Wand", "Emblem of Valor"]

  aura: itemEffects.valor 10, yes

  active: itemEffects.promote()

  maps: ["Summoner's Rift"]
