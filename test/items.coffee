items = require('../build/liblol.js').items

describe 'items', ->
  it 'should contain an Abyssal Scepter', ->
    items.list['Abyssal Scepter'].name.should.equal 'Abyssal Scepter'
