#<< items
lol.items._def "Wriggle's Lantern",
  code: 3154

  armor: 30
  ad: 15
  ls: 10

  cost: 100
  sell: 1120

  recipe: ["Madred's Razors", "Vampiric Scepter"]

  passives: [
    lol.itemEffects.maim(25, 500)
  ]

  active:
    unique: yes
    cd: 180
    range: 600
    desc: "Places a Sight Ward at target location."
