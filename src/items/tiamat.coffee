#<< items
lol.items._def "Tiamat",
  code: 3077

  ad: 50
  hp5: 15

  cost: 665
  sell: 1610

  recipe: ["Pickaxe", "Long Sword", "Rejuvenation Bead", "Rejuvenation Bead"]

  passives: [
    lol.itemEffects.cleave()
  ]

  active: lol.itemEffects.crescent()
