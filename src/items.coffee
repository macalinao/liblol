#<< main
#<< stats
#<< item_effects

lol.items = {}
lol.items.list = {}

##
# Represents an item in LoL.
# 
class LoLItem
  constructor: (name, params) ->
    @name = name

    @code = params.code

    for stat of lol.stats.names
      this[stat] = params[stat] || 0

    @cost = params.cost
    @sell = params.sell

    @recipe = params.recipe

    @auras = params.auras
    @passives = params.passives
    @active = params.active

    # Set source of all effects
    if @auras
      for aura in @auras
        aura.source = this
  
    if @passives
      for passive in @passives
        passive.source = this
  
    if @active
      @active.source = this

  getRecipe: ->
    recipe = []
    for x in @recipe
      recipe.push lol.items.list[x]
    return recipe

  getTotalCost: ->
    return @cost unless @recipe
    cost = @cost
    for r in @getRecipe()
      cost += r.getTotalCost()
    return cost

##
# Get all items that affect the given stats.
#
lol.items.getAllByStats = (statNames) ->
  ret = []
  for item in lol.items.list
    stats = lol.stats.combine [item] # Combine to get final stats in case of passives/auras
    ret.push item if lol.stats.hasStats(stats, statNames)
  return ret

##
# Sorts all items by the given comparator.
#
lol.items.sortItems = (comparator) ->
  list = []
  for itemName, item of lol.items.list
    list.push item
  list.sort comparator
  return list

##
# Makes a comparator to sort by.
#
lol.items.makeComparator = (property, asc = true) ->
  (a, b) -> 
    if asc then (a[property] || 0) - (b[property] || 0)
    else (b[property] || 0) - (a[property] || 0)

##
# Defines a new item.
# 
lol.items._def = (name, item) ->
  lol.items.list[name] = new LoLItem name, item

