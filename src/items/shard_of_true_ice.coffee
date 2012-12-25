#<< item
lol.items._def "Shard of True Ice",
  code: 3092

  ap: 45
  cost: 535
  sell: 1190

  recipe: ["Kage's Lucky Pick", "Mana Manipulator"]

  auras: [lol.itemEffects.manaWarp()]

  passives: [
    lol.itemEffects.luckyShadow()
  ]

  active:
    unique: yes
    cd: 60
    desc: "Surrounds an ally with a blizzard for 4 seconds that slows nearby enemy movement speed by 30%."
