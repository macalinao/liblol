#<< item
lol._defItem "Rod of Ages",
  code: 3027

  health: 450
  mana: 450
  ap: 60

  cost: 740
  sell: 1960

  recipe: ["Catalyst the Protector", "Blasting Wand"]

  passives: [
    {
      desc: "This item gains 20 health, 20 mana and 2 ability power every minute, up to 10 times."
    },
    itemEffects.valorsReward()
  ]
