#<< main
lol.stats =
  names:
    armor: "Armor"
    ap: "Ability Power"
    ad: "Attack Damage"
    as: "Attack Speed"
    crit: "Critical Hit Chance"
    critDmg: "Critical Hit Damage"
    health: "Health"
    mana: "Mana"
    mr: "Magic Resist"
    ms: "Movement Speed"
    aPen: "Armor Penetration"
    mPen: "Magic Penetration"

  combine: (a) ->
    finalStats = {}

    for stat, name in lol.stats.names
      finalStats[stat] = 0

      for el in a
        finalStats[stat] += el[stat]

    # Add passives
    finalStats.passives = []

    # TODO wip

    return finalStats
