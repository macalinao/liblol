#<< items
lol.items._def "Banner of Command",
  code: 3060

  ap: 50
  armor: 30

  cost: 890
  sell: 1680

  recipe: ["Blasting Wand", "Emblem of Valor"]

  auras: [lol.itemEffects.valor(10, yes)]

  active: lol.itemEffects.promote()

  maps: ["Summoner's Rift"]
