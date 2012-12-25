#<< items
lol.items._def "Eleisa's Miracle",
  code: 3173

  hp5: 10
  mp5: 15

  cost: 440
  sell: 770

  recipe: ["Philosopher's Stone"]

  passives: [
    lol.itemEffects.aid(),
    lol.itemEffects.eleisasBlessing()
  ]
