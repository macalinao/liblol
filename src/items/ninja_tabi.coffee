#<< item
lol.items._def "Ninja Tabi",
  code: 3047

  armor: 25

  cost: 350
  sell: 700

  recipe: ["Boots of Spead", "Cloth Armor"]

  passives: [
    lol.itemEffects.enhancedMovement(45),
    {
      unique: yes
      desc: "Blocks 10% of the damage from champion basic attacks."
    }
  ]
