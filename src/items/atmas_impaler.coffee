#<< item
lol.items._def "Atma's Impaler",
  code: 3005

  armor: 45
  crit: 15

  cost: 780
  sell: 1610

  recipe: ["Chain Vest", "Avarice Blade"]

  passives: [
    unique: yes
    applyToStats: (stats) -> ad: stats.health * .015
    desc: "You gain attack damage equal to 1.5% of your maximum health."
  ]
