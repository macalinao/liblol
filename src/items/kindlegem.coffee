#<< items
lol.items._def "Kindlegem",
  code: 3067

  health: 200

  cost: 275
  sell: 595

  recipe: ["Ruby Crystal"]

  passives: [
    unique: yes
    desc: "+10% cooldown reduction"
    applyToStats: (stats) -> cdr: 10
  ]
