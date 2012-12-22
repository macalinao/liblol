#<< item
lol._defItem "The Brutalizer",
  code: 3134

  ad: 25

  cost: 537
  sell: 936

  recipe: ["Long Sword", "Long Sword"]

  passives: [
    {
      unique: yes
      desc: "+10% cooldown reduction"
      applyToStats: (stats) -> cdr: 10
    },
    {
      unique: yes
      desc: "+10 armor penetration"
      applyToStats: (stats) -> aPen: 10
    }
  ]
