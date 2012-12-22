#<< item
lol._defItem "Wooglet's Witchcap",
  code: 3090

  ap: 100
  armor: 50
  cost: 1200
  sell: 2464

  recipe: ["Chain Vest", "Needlessly Large Rod"]

  active:
    unique: yes
    cd: 90
    desc: "Places your champion into stasis for 2.5 seconds, rendering you invulnerable and untargetable but unable to take any actions."

  passives: [
    unique: yes
    applyToStats: (stats) -> ap: stats.ap * 0.25
    desc: "+25% ability power"
  ]

  maps: ["Twisted Treeline", "Dominion"]
