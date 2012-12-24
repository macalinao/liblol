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

    # Get each stat
    for stat of lol.stats.names
      finalStats[stat] = 0

      # Add the stats of each item to the total stats
      for el in a
        finalStats[stat] += el[stat]

    isDuplicateEffect = (effects, e) ->
      unless e.unique
        return false

      for effect in effects
        if effect is e or effect.name is e.name
          return true

      return false

    # Add auras, passives, actives
    finalStats.auras = []
    finalStats.passives = []
    finalStats.actives = []

    for el in a
      if el.aura
        unless isDuplicateEffect finalStats.auras, el.aura
          finalStats.auras.push el.aura

      if el.passives
        for passive in el.passives
          unless isDuplicateEffect finalStats.passives, passive
            finalStats.passives.push passive
      
      if el.active
        unless isDuplicateEffect finalStats.actives, el.active
          finalStats.actives.push el.active

    return finalStats
