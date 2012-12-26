items = require("../build/liblol.js").items

describe "items", ->

  describe "find", ->

    it "should return all items when nothing is passed to it", ->
      items.find().should.include item for item in items.list

    it "should throw an error if the parameters are bad", ->
      try
        items.find "blah"
      catch e
        e.message.should.equal "Condition is not a function!"
