#<< item
lol.item "Hextech Gunblade",
  code: 3146

  ad: 45
  ap: 65
  ls: 10
  sv: 20

  cost: 275
  sell: 2380

  recipe: ["Hextech Revolver", "Bilgewater Cutlass"]

  passives: [
    {
      unique: yes
      desc: "Your basic attacks and single target spells against champions reduce the cooldown of this item by 3 seconds."
    },
    {
      unique: yes
      cd: 60
      desc: "Deals 150 + 40% of your ability power as magic damage and slows the target champion's movement speed by 40% for 2 seconds."
    }
  ]