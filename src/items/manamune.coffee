#<< items
lol.items._def "Manamune",
  code: 3004

  mana: 250
  ad: 10
  mp5: 7

  recipe: ["Tear of the Goddess", "Long Sword"]

  passives: [
    lol.itemEffects.awe(),
    lol.itemEffects.manaCharge(no, 4)
  ]
