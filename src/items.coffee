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

    setSources = (effects) -> e.source = this for e in effects

    # Set source of all effects
    setSources @auras if @auras
    setSources @passives if @passives
    @active.source = this if @active

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
# Finds all items that fulfill a filter.
# 
lol.items.find = (filter) ->
  unless filter?
    filter = (item) -> true
  
  unless typeof filter is "function"
    throw new Error "Filter is not a function!"

  ret = []
  for itemName, item of lol.items.list
    ret.push item if filter item

  return ret

##
# Item filters for use in find().
#
lol.items.filters =
  ##
  # Checks if the item has the given stats set.
  #
  withStats: (statNames) ->
    (item) -> lol.stats.hasStats lol.stats.combine([item]), statNames

##
# Item sorts (comparators) for use in find().
#
lol.items.sorts =
  ##
  # Sorts by property.
  #
  byProperty: (property, asc = true) ->
    (a, b) -> 
      pa = a[property] || 0
      pb = b[property] || 0

      unless typeof pa is "number" and typeof pb is "number"
        throw new Error "The property must be a number."

      if asc then pa - pb else pb - pa

##
# Defines a new item.
# 
lol.items._def = (name, item) ->
  lol.items.list[name] = new LoLItem name, item

