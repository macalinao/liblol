#<< items
lol.items._def "Boots of Swiftness",
  code: 3009

  cost: 650
  sell: 700

  recipes: ["Boots of Speed"]

  passives: [
    lol.itemEffects.enhancedMovement(60),
    lol.itemEffects.slowResist()
  ]
