{stats, items, itemEffects} = require("../build/liblol")

describe "items", ->
  find = items.find
  findOne = items.findOne
  
  withStats = items.filters.withStats
  OR = items.filters.or
  AND = items.filters.and
  NOT = items.filters.not
  where = items.filters.where
  byProperty = items.sorts.byProperty

  hextechGunblade = items._list["Hextech Gunblade"]

  describe "LoLItem", ->
    testItem = new items.LoLItem "Hecate II",
      ad: 400
      as: 50

      recipe: ["B. F. Sword", "The Black Cleaver"]

      cost: 820
      sell: 911

      passives: [
        itemEffects.cleave(),
        {
          desc: "Your attacks have an increased accuracy depending on your heartbeat."
        }
      ]

      active:
        desc: "Destroys any target on the map."
        range: 9001

      auras: [
        desc: "Lowers the armor penetration of all surrounding enemies by 20%."
      ]

    describe "constructor", ->

      it "should inherit the stats passed to it", ->
        testItem.ad.should.equal 400
        testItem.as.should.equal 50

      it "should zero all other stats that it doesn't include", ->
        for name of stats.names
          testItem[name].should.equal 0 if ["ad", "as"].indexOf(name) is -1

      it "should set the sources of passives to the item", ->
        passive.source.should.equal testItem for passive in testItem.passives

      it "should set the source of active to the item", ->
        testItem.active.source.should.equal testItem

      it "should set the sources of auras to the item", ->
        aura.source.should.equal testItem for aura in testItem.auras

    describe "getRecipe", ->

      it "should get the objects of the items that are part of the recipe", ->
        testItem.getRecipe().should.eql [findOne("B. F. Sword"), findOne("The Black Cleaver")]

    describe "getBuildsInto", ->

      it "should return nothing if the item builds into nothing", ->
        hextechGunblade.getBuildsInto().should.be.empty

      it "should return all of the items the item is a direct part of the recipe of", ->
        itemNames = []
        for item in findOne("Vampiric Scepter").getBuildsInto()
          itemNames.push item.name
        itemNames.sort().should.eql ["Bilgewater Cutlass", "The Bloodthirster", "Wriggle's Lantern", "Zeke's Herald"].sort()

    describe "getTotalCost", ->

      it "should add up the total costs of the items below it and the cost of the item", ->
        testItem.getTotalCost().should.equal testItem.cost + findOne("B. F. Sword").getTotalCost() + findOne("The Black Cleaver").getTotalCost()

      it "should use the item's cost if the item is a basic item (no recipe)", ->
        longSword = findOne "Long Sword"
        longSword.getTotalCost().should.equal longSword.cost

    describe "toString", ->

      it "should use the item's name", ->
        testItem.toString().should.equal testItem.name

  describe "find", ->

    it "should return all items when nothing is passed to it", ->
      find().should.include item for item in items._list

    it "should get the item by name if a string is passed", ->
      find("Hextech Gunblade").should.eql [hextechGunblade]

    it "should use the 'where' filter if an object is passed", ->
      find(name: "Hextech Gunblade").should.eql [hextechGunblade]

    it "should throw an error if the filter isn't a string, object, or function", ->
      try
        find 3.14
        chai.assert.fail(0, 0, "Invalid value didn't error!")
      catch e

    it "should return a blank array if the filter is never true", ->
      find(-> false).should.eql []

    describe "filters", ->

      describe "and", ->

        it "should include no cases if one filter has no results", ->
          find(AND (-> false), (-> true)).should.eql []

        it "should include only cases that fulfill both filters", ->
          list = find(AND withStats(["ap"]), withStats(["ad"]))

          list.should.include hextechGunblade # ap and ad
          list.should.not.include findOne("Hextech Revolver") # ap
          list.should.not.include findOne("Bilgewater Cutlass") # ad

      describe "or", ->

        it "should include all cases if one filter has all results", ->
          find(OR (-> false), (-> true)).length.should.equal find().length

        it "should include cases that fulfill any filters", ->
          list = find(OR withStats(["ap"]), withStats(["ad"]))

          list.should.include hextechGunblade # ap and ad
          list.should.include findOne("Hextech Revolver") # ap
          list.should.include findOne("Bilgewater Cutlass") # ad
          list.should.not.include findOne("Warmog's Armor") # none

      describe "not", ->

        it "should include nothing if the filter includes everything", ->
          find(NOT -> true).should.eql []

        it "should include nothing with ap if the filter includes everything with ap", ->
          list = find(NOT withStats(["ap"]))
          item.ap.should.equal 0 for item in list

      describe "where", ->
        it "should check using a provided function if the parameter is a function", ->
          find(where name: "Hextech Gunblade", ap: (val) -> 65).should.eql [hextechGunblade]

        it "should check for equality if the parameter isn't a query object", ->
          find(where name: "Hextech Gunblade").should.eql [hextechGunblade]

        it "should error if the value passed to the handler is invalid", ->
          try
            find(where name: gte: "Hextech Gunblade")
            chai.assert.fail(0, 0, "Invalid property type didn't error!")
          catch e

        it "should error if the argument passed to the handler is invalid", ->
          try
            find(where ap: gte: "Hextech Gunblade")
            chai.assert.fail(0, 0, "Invalid argument didn't error!")
          catch e

        it "should check for equality with the 'eq' filter", ->
          find(where name: eq: "Hextech Gunblade").should.eql [hextechGunblade]

        it "should check for non-equality with the 'neq' filter", ->
          find(where name: neq: "Hextech Gunblade").should.not.include [hextechGunblade]

        it "should check for >= with the 'gte' filter", ->
          find(where name: "Hextech Gunblade", ap: gte: 65).should.eql [hextechGunblade]
          find(where name: "Hextech Gunblade", ap: gte: 66).should.eql []

        it "should check for > with the 'gt' filter", ->
          find(where name: "Hextech Gunblade", ap: gt: 64).should.eql [hextechGunblade]
          find(where name: "Hextech Gunblade", ap: gt: 65).should.eql []

        it "should check for <= with the 'lte' filter", ->
          find(where name: "Hextech Gunblade", ap: lte: 65).should.eql [hextechGunblade]
          find(where name: "Hextech Gunblade", ap: lte: 64).should.eql []

        it "should check for < with the 'lt' filter", ->
          find(where name: "Hextech Gunblade", ap: lt: 66).should.eql [hextechGunblade]
          find(where name: "Hextech Gunblade", ap: lt: 65).should.eql []

        it "should check for string containing with the 'contains' filter", ->
          find(where name: eq: "Hextech Gunblade", contains: "extech").should.eql [hextechGunblade]
          find(where name: eq: "Hextech Gunblade", contains: 32).should.eql []
          find(where name: eq: "Hextech Gunblade", contains: "extch ").should.eql []

        it "should check regex with the 'matches' filter", ->
          find(where name: eq: "Hextech Gunblade", matches: /exte[c|z]h/).should.eql [hextechGunblade]
          find(where name: eq: "Hextech Gunblade", matches: /exte[s|z]h/).should.eql []

        it "should error if the 'matches' filter is given something other than a regex", ->
          try
            find(where name: eq: "Hextech Gunblade", matches: {})
            chai.assert.fail 0, 0, "Invalid value didn't error!"
          catch e

          try
            find(where name: eq: "Hextech Gunblade", matches: 3.14)
            chai.assert.fail 0, 0, "Invalid value didn't error!"
          catch e

        it "should work with multiple query filters applied at once", ->
          find(where name: "Hextech Gunblade", ap: lt: 66, gt: 54).should.eql [hextechGunblade]
          find(where name: "Hextech Gunblade", ap: lt: 69, gt: 65).should.eql []

      describe "withStats", ->

        it "should not include items without the stat", ->
          find(withStats(["ap"])).should.not.include findOne("B. F. Sword")

        it "should include items with the stat", ->
          find(withStats(["ap"])).should.include findOne("Needlessly Large Rod")

        it "should include items with multiple stats", ->
          find(withStats(["ap", "ad"])).should.include hextechGunblade

        it "should include items with a stat in a passive", ->
          find(withStats(["hp5"])).should.include findOne("Warmog's Armor")

  describe "findOne", ->

    it "should find the first item and return it", ->
      findOne("Hextech Gunblade").should.equal hextechGunblade

    it "should return null if no item was found", ->
      chai.assert.isTrue findOne("Needlessly Small Rod") is null

  describe "sorts", ->

    describe "byProperty", ->

      it "should error if the property is not a number", ->
        try
          find().sort byProperty("name")
          chai.assert.fail(0, 0, "Invalid value didn't error!")
        catch e

      it "should sort ascending by default", ->
        res = find(withStats(["ap"])).sort byProperty("ap")
        (res[0].ap < res[res.length - 1].ap).should.be.true

      it "should sort descending if needed", ->
        res = find(withStats(["ap"])).sort byProperty("ap", no)
        (res[0].ap > res[res.length - 1].ap).should.be.true
