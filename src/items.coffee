#<< main
#<< stats
#<< item_effects

lol.items = {}
lol.items._list = {}

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

    setSources = (effects) => e.source = this for e in effects

    # Set sources of all effects
    [@auras, @passives].map (el) -> setSources el if el
    @active.source = this if @active

    # Calculate stats
    @stats = lol.stats.combine [this]

  getRecipe: ->
    recipe = []
    for x in @recipe
      recipe.push lol.items.findOne[x]
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
    filter = (item) -> true # Filterless filter

  type = typeof filter

  if type is "string"
    return lol.items.find name: filter

  else if type is "object"
    return lol.items.find lol.items.filters.where filter

  else if type is "function"
    ret = []
    for itemName, item of lol.items._list
      ret.push item if filter item

    return ret
  else
      throw new Error "Invalid arguments for find!"

##
# Finds the first item that fulfills a filter.
#
lol.items.findOne = (filter) ->
  res = lol.items.find filter
  if res.length is 0 then null else res[0]

##
# Item filters for use in find().
#
lol.items.filters =
  ##
  # Combines all filters in the arguments, returning true if all filters are true.
  #
  and: -> 
    args = arguments
    (item) ->
      for filter in args
        return false if typeof filter isnt "function" or filter(item) is false
      return true

  ##
  # Combines all filters in the arguments, returning true if one or more filters are true.
  #
  or: -> 
    args = arguments
    (item) ->
      for filter in args
        return true if typeof filter is "function" and filter(item) is true
      return false

  ##
  # Negates a filter.
  #
  not: (filter) -> (item) -> not filter item

  ##
  # Where -- complex filter that takes in a query object.
  #
  where: (params) ->
    (item) ->
      for paramName, param of params
        # Handle passives, active, and auras
        if ["passives", "active", "auras"].indexOf(paramName) isnt -1
          return false # TODO

        # Check for matching a function
        if typeof param is "function"
          return false unless param item[paramName]

        # Check for equality
        else if typeof param isnt "object"
          return false if item[paramName] isnt param

        # It's a query!
        for handlerName, handler of lol.items._queryHandlers
          if param[handlerName]
            # Check if the handler is of the right type
            if handler.types
              for type in handler.types
                if typeof param[handlerName] isnt type
                  throw new Error "Invalid type for filter value '#{param[handlerName]}'! Available types are: #{handler.types.join(", ")}"

            # Does not match filter unless the handler is triggered correctly
            return false unless handler.handler item[paramName], param[handlerName]

      return true

  ##
  # Checks if the item has the given stats set.
  #
  withStats: (statNames) ->
    (item) -> lol.stats.hasStats item.stats, statNames

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

lol.items._queryHandlers =
  eq:
    handler: (property, val) -> property is val
  
  neq:
    handler: (property, val) -> property isnt val

  gte:
    types: ["number"]
    handler: (property, val) -> property >= val

  gt:
    types: ["number"]
    handler: (property, val) -> property > val

  lte:
    types: ["number"]
    handler: (property, val) -> property <= val

  lt:
    types: ["number"]
    handler: (property, val) -> property < val

  matches:
    types: ["object"]
    handler: (property, val) ->
      throw new Error "Argument must be a regular expression!" unless val instanceof RegExp
      val.test property

##
# Defines a new item.
# 
lol.items._def = (name, item) ->
  lol.items._list[name] = new LoLItem name, item

