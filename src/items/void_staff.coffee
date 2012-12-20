#<< item
lol.item "Void Staff",
  code: 3135

  ap: 70

  cost: 1000
  sell: 1607

  recipe: ["Amplifying Tome", "Blasting Wand"]

  passives: [
    unique: yes
    desc: "+35% magic penetration"
    applyToStats: (stats) -> mPen: 35
  ]
