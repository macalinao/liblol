#<< champions

# NOTE:
# Jax is obviously not like this, but this is a template while I have no internet!
lol.champions._def "Jax",
  baseStats:
    health: 463
    hp5: 7.45
    mana: 230
    mp5: 6.4
    range: 125
    ad: 56.3
    as: 0.638
    armor: 18
    mr: 30
    ms: 350

  statsPerLevel:
    health: 98
    hp5: 0.55
    mana: 35
    mp5: 0.7
    ad: 3.375
    as: 3.4
    armor: 3.5
    mr: 1.25

  skills:
    passive:
      name: "Blahblah"
      passives: [] # Some people have 2 in one passives, like Akali IIRC

    q:
      name: "Leap Strike"
      desc: (stats) -> "blah blah blah for 300 (+" + (stats.ap * 0.7) + ") magic damage"
    
    w:
      name: "Empower"

    e:
      name: "Counter Strike"

    r:
      name: "Grandmaster's Might"
      passives: [] # Whatever
