#<< item
lol.item "Shurelya's Reverie",
  code: 3069

  health: 250
  hp5: 10
  mp5: 10

  cost: 550
  sell: 1470

  recipe: ["Kindlegem", "Philosopher's Stone"]

  passives: [
    unique: yes
    desc: "+10% cooldown reduction"
    applyToStats: (stats) -> cdr: 10
  ]

  active:
    unique: yes
    cd: 60
    range: 600
    desc: "Nearby champions gain 40% movement speed for 3 seconds."
