#<< item
lol._defItem "Infinity Edge",
  code: 3031

  ad: 70
  crit: 25

  cost: 645
  sell: 2681

  recipe: ["B. F. Sword", "Pickaxe", "Cloak of Agility"]

  passives: [
    unique: yes
    desc: "+50% critical strike damage."
    applyToStats: (stats) -> critDmg: 50
  ]
