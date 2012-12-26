items = require('../build/liblol.js').items

describe 'items', ->
  describe 'find', ->
    it 'should return all items when nothing is passed to it', ->
      items.find().should.contain item for item in items.list
