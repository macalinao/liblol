#<< main
lol.champions = {}

class LoLChampion
  constructor: (name, params) ->
    @name = name

    @baseStats = params.baseStats
    @statsPerLevel = params.statsPerLevel

    @skills = params.skills

  ##
  # Gets the stats of the champion at a given level
  # without items, masteries, runes, etc.
  #
  getVanillaStats: (level) ->
    stats = {}

    for stat in lol.stats.names
      stats[stat] = (@baseStats[stat] || 0) + (level - 1) * (@statsPerLevel[stat] || 0)

    return stats

  ##
  # Gets the stats of the champion at a given level
  # with the given items, masteries, and runes.
  # 
  getStats: (level, items, masteries, runes) ->
    return lol.stats.combine [@getItemlessStats(level), lol.stats.combine(items), lol.stats.combine(masteries), lol.stats.combine(runes)]

lol.champions.list = {}
lol.champions._def = (name, params) ->
  lol.champions.list[name] = new LoLChampion name, params
