#<< item
lol.items._def "Nashor's Tooth",
  code: 3115

  ap: 65
  as: 50
  mp5: 10

  cost: 250
  sell: 1750

  recipe: ["Stinger", "Fiendish Codex"]

  passive: [
    unique: yes
    desc: "+20% cooldown reduction"
    applyToStats: (stats) -> cdr: 20
  ]
