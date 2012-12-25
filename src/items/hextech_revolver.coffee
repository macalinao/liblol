#<< items
lol.items._def "Hextech Revolver",
  code: 3145

  ap: 40

  cost: 330
  sell: 840

  recipe: ["Amplifying Tome", "Amplifying Tome"]

  passives: [
    unique: yes
    desc: "+12% spell vamp"
    applyToStats: (stats) -> sv: 12
  ]
