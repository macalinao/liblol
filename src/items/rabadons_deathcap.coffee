#<< item
item "Rabadon's Deathcap",
  code: 3089

  ap: 120
  cost: 740
  sell: 2520

  recipe: ["Blasting Wand", "Needlessly Large Rod"]

  passives: [
    unique: yes
    applyToStats: (stats) -> ap: stats.ap * 0.25
    desc: "+25% ability power"
  ]

  maps: ["Summoner's Rift", "Proving Grounds"]
