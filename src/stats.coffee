#<< main
lol.stats =
  ##
  # The names of all stats.
  # 
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
    range: "Range"
    gp10: "Gold per Ten"
    hp5: "Health Regen"
    mp5: "Mana Regen"

  ##
  # Combines multiple stats together.
  #
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
    auras = []
    passives = []
    actives = []

    # Check all item effects
    for el in a
      # Check auras
      if el.aura
        unless isDuplicateEffect finalStats.auras, el.aura
          auras.push el.aura

      # Check passives
      if el.passives
        for passive in el.passives
          unless isDuplicateEffect finalStats.passives, passive
            passives.push passive
      
      # Check actives
      if el.active
        unless isDuplicateEffect finalStats.actives, el.active
          actives.push el.active

    # Only add the arrays if they have effects
    if auras.length > 0
      finalStats.auras = auras
    if passives.length > 0
      finalStats.passives = passives
    if actives.length > 0
      finalStats.actives = actives

    return finalStats
