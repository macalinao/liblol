items = require("../build/liblol.js").items

describe "items", ->

  describe "find", ->

    it "should return all items when nothing is passed to it", ->
      items.find().should.include item for item in items.list

    it "should throw an error if the condition isn't a function", ->
      try
        items.find "blah"
      catch e
        e.message.should.equal "Condition is not a function!"

    it "should return a blank array if the condition is never true", ->
      items.find(-> false).should.eql []

    it "should throw an error if the comparator isn't a function", ->
      try
        items.find (-> false), "not a func"
      catch e
        e.message.should.equal "Comparator is not a function!"

    it "should sort if a comparator is given", ->
      # Put a filter to not have a huge eql
      filter = (item) -> item.name.substring(0, 1) is "A"
      comparator = (a, b) -> a.ap - b.ap

      items.find(filter).sort(comparator).should.eql items.find filter, comparator
