#<< items
lol.items._def "Mikael's Crucible",
  code: 3222

  mana: 300
  mr: 40
  mp5: 9
  cost: 920
  sell: 1540

  recipe: ["Chalice of Harmony", "Sapphire Crystal"]

  active:
    unique: yes
    cd: 180
    desc: "Removes all stuns, roots, taunts, fears, silences and slows on an ally and heals them for 150 + 15% of their missing health."

  passives: [
    lol.itemEffects.manaFont()
  ]
