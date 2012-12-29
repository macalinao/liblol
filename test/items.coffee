items = require("../build/liblol.js").items

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
      catch e
        e.message.should.equal "Invalid arguments for find!"

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
        it "should check for equality if the parameter isn't a query object", ->
          find(where name: "Hextech Gunblade").should.eql [hextechGunblade]

        it "should error if the value passed to the filter is invalid", ->
          try
            find(where name: gte: "Hextech Gunblade")
            chai.assert.fail(0, 0, "Invalid value didn't error!")
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

        it "should work with custom filters with 'matches'", ->
          find(where name: "Hextech Gunblade", ap: matches: (val) -> 65).should.eql [hextechGunblade]

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
      true.should.equal findOne("Needlessly Small Rod") is null

  describe "sorts", ->

    describe "byProperty", ->

      it "should error if the property is not a number", ->
        try
          find().sort byProperty("name")
        catch e
          e.message.should.equal "The property must be a number."

      it "should sort ascending by default", ->
        res = find(withStats(["ap"])).sort byProperty("ap")
        (res[0].ap < res[res.length - 1].ap).should.be.true

      it "should sort descending if needed", ->
        res = find(withStats(["ap"])).sort byProperty("ap", no)
        (res[0].ap > res[res.length - 1].ap).should.be.true
