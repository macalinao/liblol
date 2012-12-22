#<< item
lol._defItem "Last Whisper",
  code: 3035

  ad: 40

  cost: 860
  sell: 1494

  recipe: ["Long Sword", "Pickaxe"]

  passives: [
    unique: yes
    desc: "+35 armor penetration"
    applyToStats: (stats) -> aPen: 35
  ]
