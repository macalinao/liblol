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

  toString: -> @name

##
# Finds all items that fulfill a condition and sorts them by the given comparator.
# 
lol.items.find = (condition, comparator) ->
  unless condition? and typeof condition is "function"
    condition = (item) -> true

  ret = []
  for itemName, item of lol.items.list
    ret.push item if condition item

  return ret unless comparator? and typeof comparator is "function"
  return ret.sort comparator

##
# Item conditions for use in find().
#
lol.items.conditions =
  ##
  # Checks if the item has the given stats set.
  #
  withStats: (statNames) ->
    (item) -> lol.stats.hasStats lol.stats.combine([item]), statNames

##
# Item comparators for use in find().
#
lol.items.comparators =
  ##
  # Compares by property.
  #
  byProperty: (property, asc = true) ->
    (a, b) -> 
      if asc then (a[property] || 0) - (b[property] || 0)
      else (b[property] || 0) - (a[property] || 0)

##
# Defines a new item.
# 
lol.items._def = (name, item) ->
  lol.items.list[name] = new LoLItem name, item

