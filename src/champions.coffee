#<< main
lol.champions = {}

class LoLChampion
  constructor: (name, params) ->
    @name = name

    @baseStats = params.baseStats
    @statsPerLevel = params.statsPerLevel

    @skills = params.skills

  ##
  # Applies stats to the base stats of this champion.
  #
  applyStats: (stats) ->
    stats = {}
    for stat in lol.stats.names
      unless stat is "as"
        stats[stat] = (@baseStats[stat] || 0) + (stats[stat] || 0)
      else
        stats[stat] = (@baseStats[stat] || 0) * (stats[stat] || 0)
    return stats

  ##
  # Gets the stats of the champion at a given level
  # without items, masteries, runes, etc.
  #
  getVanillaStats: (level) ->
    return applyStats getAdditionalStats level

  ##
  # Gets the additional stats to add to the champion for the given level.
  #
  getAdditionalStats: (level) ->
    added = {}

    for stat in lol.stats.names
      added[stat] = (level - 1) * (@statsPerLevel[stat] || 0)

    return added

  ##
  # Gets the stats of the champion at a given level
  # with the given items, masteries, and runes.
  # 
  getStats: (level, items, masteries, runes) ->
    return applyStats lol.stats.combine [@getAdditionalStats(level), lol.stats.combine(items), lol.stats.combine(masteries), lol.stats.combine(runes)]

lol.champions.list = {}
lol.champions._def = (name, params) ->
  lol.champions.list[name] = new LoLChampion name, params
