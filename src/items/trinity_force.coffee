#<< item
lol.items._def "Trinity Force",
  code: 3078

  ap: 30
  ad: 30
  as: 30
  crit: 10
  health: 250
  mana: 200
  ms: 8

  cost: 300
  sell: 2940

  recipe: ["Zeal", "Sheen", "Phage"]

  passives: [
    lol.itemEffects.icy 25, 30, 2, 20,
    lol.itemEffects.spellblade "After using an ability, your next basic attack deals bonus damage equal to 150% of your base attack damage as physical damage. (2 second cooldown)"
  ]
