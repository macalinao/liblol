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
      return false unless e.unique
      return true if effect is e or effect.name is e.name for effect in effects
      return false

    # Add auras, passives, actives
    finalStats.auras = []
    finalStats.passives = []
    finalStats.actives = []

    for el in a
      finalStats.auras.push el.aura unless isDuplicateEffect finalStats.auras, el.aura
      for passive in el.passives
        finalStats.passives.push passive unless isDuplicateEffect finalStats.passives, passive
      finalStats.actives.push el.active unless isDuplicateEffect finalStats.actives, el.active

    return finalStats
