#<< item
lol._defItem "Manamune",
  code: 3004

  mana: 250
  ad: 10
  mp5: 7

  recipe: ["Tear of the Goddess", "Long Sword"]

  passives: [
    itemEffects.awe(),
    itemEffects.manaCharge(no, 4)
  ]
