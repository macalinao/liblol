#<< main
lol.champions = {}

class LoLChampion
  constructor: (name, params) ->
    @name = name

    @baseStats = params.baseStats
    @statsPerLevel = params.statsPerLevel

    @skills = params.skills

lol.champions.list = {}
lol._defChamp = (name, params) ->
  lol.champions.list[name] = new LoLChampion name, params
