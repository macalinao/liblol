#<< item
lol._defItem "Mercury's Treads",
  code: 3111

  mr: 25

  cost: 450
  sell: 840

  recipe: ["Boots of Speed", "Null-Magic Mantle"]

  passives: [
    lol.itemEffects.enhancedMovement(45),
    lol.itemEffects.tenacity()
  ]
