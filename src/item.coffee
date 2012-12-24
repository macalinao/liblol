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

    @aura = params.aura
    @passives = params.passives
    @active = params.active

    # Set source of all effects
    if @aura
      @aura.source = this
  
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

lol._defItem = (name, item) ->
  lol.items.list[name] = new LoLItem name, item

