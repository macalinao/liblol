#<< item
lol._defItem "Madred's Razors",
  code: 3106

  armor: 25

  cost: 100
  sell: 490

  recipe: ["Cloth Armor", "Hunter's Machete"]

  passives: [
    lol.itemEffects.maim(25, 300),
    lol.itemEffects.rend()
  ]
