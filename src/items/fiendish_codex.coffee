#<< item
lol._defItem "Fiendish Codex",
  code: 3108

  ap: 30
  mp5: 6

  cost: 385
  sell: 700

  recipe: ["Faerie Charm", "Amplifying Tome"]

  passives: [
    unique: yes
    applyToStats: (stats) -> cdr: stats.cdr * .1
    desc: "+10% cooldown reduction"
  ]
