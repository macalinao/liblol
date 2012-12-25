#<< item
lol.items._def "Stinger",
  code: 3101

  as: 40

  cost: 450
  sell: 875

  recipe: ["Dagger", "Dagger"]

  passives: [
    unique: yes
    desc: "+10% cooldown reduction"
    applyToStats: (stats) -> cdr: 10
  ]
