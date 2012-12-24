#<< champion

# NOTE:
# Jax is obviously not like this, but this is a template while I have no internet!
lol._defChamp "Jax",
  baseStats:
    health: 0
    ap: 0

  statsPerLevel:
    health: 3.14
    ap: 5.1

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
