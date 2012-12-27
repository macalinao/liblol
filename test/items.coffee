items = require("../build/liblol.js").items

describe "items", ->

  describe "find", ->

    it "should return all items when nothing is passed to it", ->
      items.find().should.include item for item in items.list

    it "should throw an error if the filter isn't a function", ->
      try
        items.find "blah"
      catch e
        e.message.should.equal "Filter is not a function!"

    it "should return a blank array if the filter is never true", ->
      items.find(-> false).should.eql []

    describe "filters", ->

      describe "withStats", ->

        it "should not include items without the stat", ->
          items.find(items.filters.withStats(["ap"])).should.not.include items.list["B. F. Sword"]

        it "should include items with the stat", ->
          items.find(items.filters.withStats(["ap"])).should.include items.list["Needlessly Large Rod"]

        it "should include items with multiple stats", ->
          items.find(items.filters.withStats(["ap", "ad"])).should.include items.list["Hextech Gunblade"]

        it "should include items with a stat in a passive", ->
          items.find(items.filters.withStats(["hp5"])).should.include items.list["Warmog's Armor"]

  describe "sorts", ->

    describe "byProperty", ->

      it "should error if the property is not a number", ->
        try
          items.find().sort items.sorts.byProperty("name")
        catch e
          e.message.should.equal "The property must be a number."

      it "should sort ascending by default", ->
        res = items.find(items.filters.withStats(["ap"])).sort items.sorts.byProperty("ap")
        (res[0].ap < res[res.length - 1].ap).should.be.true

      it "should sort descending if needed", ->
        res = items.find(items.filters.withStats(["ap"])).sort items.sorts.byProperty("ap", no)
        (res[0].ap > res[res.length - 1].ap).should.be.true
