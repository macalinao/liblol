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
    initialStats = {}

    # Get each stat
    for stat of lol.stats.names
      initialStats[stat] = 0

      # Add the stats of each item to the total stats
      for el in a
        if el[stat]
          initialStats[stat] += el[stat]

    isDuplicateEffect = (effects, e) ->
      unless e.unique
        return false

      for effect in effects
        if effect is e or (effect.name and effect.name is e.name)
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
        unless isDuplicateEffect auras, el.aura
          auras.push el.aura

      # Check passives
      if el.passives
        for passive in el.passives
          unless isDuplicateEffect passives, passive
            passives.push passive
      
      # Check actives
      if el.active
        unless isDuplicateEffect actives, el.active
          actives.push el.active

    # Apply auras and passives
    finalStats = {}

    # If we do have auras/passives, calculate the extra
    if auras.length > 0 or passives.length > 0
      # Apply all of the stats
      effectsStats = []
      for aura in auras
        if aura.applyToStats
          effectsStats.push aura.applyToStats initialStats
      for passive in passives
        if passive.applyToStats
          effectsStats.push passive.applyToStats initialStats

      # Combine all of the effects together
      effectStats = lol.stats.combine effectsStats

      # Create the final product
      finalStats = lol.stats.combine [initialStats, effectStats]
    
      # Add our auras and passives to the final product
      finalStats.auras = auras
      finalStats.passives = passives

    # If no auras/passives, no need to calculate
    else
      finalStats = initialStats


    # Add all the actives to the final product if they exist
    if actives.length > 0
      finalStats.actives = actives

    return finalStats
