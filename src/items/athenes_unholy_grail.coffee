#<< items
lol.items._def "Athene's Unholy Grail",
  code: 3174

  ap: 60
  mr: 40
  mp5: 15

  cost: 920
  sell: 1960

  recipe: ["Fiendish Codex", "Chalice of Harmony"]

  passives: [
    {
      unique: yes
      applyToStats: (stats) -> cdr: stats.cdr * 0.15
      desc: "15% cooldown reduction"
    },
    {
      unique: yes
      desc: "Restores 12% of your max mana on kill or assist."
    },
    lol.itemEffects.manaFont()
  ]
