#<< item
lol.item "Randuin's Omen",
  code: 3143

  health: 500
  armor: 70

  cost: 1000
  sell: 2170

  recipe: ["Giant's Belt", "Warden's Mail"]

  passives: [
    itemEffects.coldSteel(20, 10, 1.5)
  ]

  active:
    unique: yes
    cd: 60
    range: 500
    desc: "Slows the movement speed of nearby enemy units by 35% for 2 seconds + 1 second for every 100 armor and magic resistance you have."
