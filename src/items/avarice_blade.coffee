#<< items
lol.items._def "Avarice Blade",
  code: 3093

  crit: 10
  cost: 400
  sell: 400

  recipe: ["Brawler's Gloves"]

  passives: [
    lol.itemEffects.avarice(),
    lol.itemEffects.greed()
  ]
