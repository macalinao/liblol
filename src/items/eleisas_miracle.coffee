#<< item
lol.item "Eleisa's Miracle",
  code: 3173

  hp5: 10
  mp5: 15

  cost: 440
  sell: 770

  recipe: ["Philosopher's Stone"]

  passives: [
    itemEffects.aid(),
    itemEffects.eleisasBlessing()
  ]