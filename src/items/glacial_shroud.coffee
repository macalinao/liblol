#<< item
item "Glacial Shroud",
  code: 3024

  armor: 40
  mana: 300
  cost: 380
  sell: 1050

  recipe: ["Sapphire Crystal", "Chain Vest"]

  passives: [
    unique: yes
    desc: "+15% cooldown reduction"
    applyToStats: (stats) -> cdr: 15
  ]
