#<< item
lol._defItem "Warmog's Armor",
  code: 3080

  health: 1000

  cost: 995
  sell: 1855

  recipe: ["Giant's Belt", "Ruby Crystal", "Rejuvenation Bead"]

  passives: [
    unique: yes
    desc: "You gain health regeneration equal to 1.5% of your maximum health."
    applyToStats: (stats) -> hp5: stats.health * 0.015
  ]
