#<< item
lol.items._def "Youmuu's Ghostblade",
  code: 3142

  ad: 30
  crit: 15
  cdr: 10

  recipe: ["Avarice Blade", "The Brutalizer"]

  passives: [
    unique: yes
    desc: "+20 armor penetration"
    applyToStats: (stats) -> aPen: 20
  ]

  active:
    unique: yes
    cd: 45
    desc: "Gain +40% attack speed and +20% movement speed for 6 seconds (4 seconds for ranged champions)."
