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

    @armor = params.armor || 0
    @ap = params.ap || 0
    @ad = params.ad || 0
    @as = params.as || 0
    @crit = params.crit || 0
    @critDmg = params.critDmg || 0
    @health = params.health || 0
    @mana = params.mana || 0
    @mr = params.mr || 0
    @ms = params.ms || 0
    @aPen = params.aPen || 0
    @mPen = params.mPen || 0

    @cost = params.cost
    @sell = params.sell

    @recipe = params.recipe

    @aura = params.aura
    @passives = params.passives
    @active = params.active

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

