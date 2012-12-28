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

      describe "and", ->

        it "should include no cases if one filter has no results", ->
          items.find(items.filters.and (-> false), (-> true)).should.eql []

        it "should include only cases that fulfill both filters", ->
          list = items.find(items.filters.and items.filters.withStats(["ap"]), items.filters.withStats(["ad"]))

          list.should.include items.list["Hextech Gunblade"] # ap and ad
          list.should.not.include items.list["Hextech Revolver"] # ap
          list.should.not.include items.list["Bilgewater Cutlass"] # ad

      describe "or", ->

        it "should include all cases if one filter has all results", ->
          items.find(items.filters.or (-> false), (-> true)).length.should.equal items.find().length

        it "should include cases that fulfill any filters", ->
          list = items.find(items.filters.or items.filters.withStats(["ap"]), items.filters.withStats(["ad"]))

          list.should.include items.list["Hextech Gunblade"] # ap and ad
          list.should.include items.list["Hextech Revolver"] # ap
          list.should.include items.list["Bilgewater Cutlass"] # ad
          list.should.not.include items.list["Warmog's Armor"] # none

      describe "not", ->

        it "should include nothing if the filter includes everything", ->
          items.find(items.filters.not -> true).should.eql []

        it "should include nothing with ap if the filter includes everything with ap", ->
          list = items.find(items.filters.not items.filters.withStats(["ap"]))
          item.ap.should.equal 0 for item in list

      describe "where", ->
        where = items.filters.where

        it "should check for equality if the parameter isn't a query object", ->
          items.find(where name: "Hextech Gunblade").should.eql [items.list["Hextech Gunblade"]]

        it "should check for equality with the 'eq' filter", ->
          items.find(where name: eq: "Hextech Gunblade").should.eql [items.list["Hextech Gunblade"]]

        it "should check for >= with the 'gte' filter", ->
          items.find(where name: "Hextech Gunblade", ap: gte: 65).should.eql [items.list["Hextech Gunblade"]]
          items.find(where name: "Hextech Gunblade", ap: gte: 66).should.eql []

        it "should check for > with the 'gt' filter", ->
          items.find(where name: "Hextech Gunblade", ap: gt: 64).should.eql [items.list["Hextech Gunblade"]]
          items.find(where name: "Hextech Gunblade", ap: gt: 65).should.eql []

        it "should check for <= with the 'lte' filter", ->
          items.find(where name: "Hextech Gunblade", ap: lte: 65).should.eql [items.list["Hextech Gunblade"]]
          items.find(where name: "Hextech Gunblade", ap: lte: 64).should.eql []

        it "should check for < with the 'lt' filter", ->
          items.find(where name: "Hextech Gunblade", ap: lt: 66).should.eql [items.list["Hextech Gunblade"]]
          items.find(where name: "Hextech Gunblade", ap: lt: 65).should.eql []

        it "should work with multiple query filters applied at once", ->
          items.find(where name: "Hextech Gunblade", ap: lt: 66, gt: 54).should.eql [items.list["Hextech Gunblade"]]
          items.find(where name: "Hextech Gunblade", ap: lt: 69, gt: 65).should.eql []

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
