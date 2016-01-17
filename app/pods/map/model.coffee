`import DS from 'ember-data'`

Map = DS.Model.extend
  name:        DS.attr    'string', defaultValue: new Date().toISOString()
  hexes:       DS.hasMany 'hex'
  players:     DS.hasMany 'player', { inverse: 'maps' }
  isDefault:   DS.attr    'boolean'
  fileName:    DS.attr    'string'
  mode:        DS.attr    'string'
  turnsPassed: DS.attr    'number'
  stats:       DS.attr()

  activePlayer: Ember.computed 'players', -> @get('players').objectAt(0)

  getNextPlayer: Ember.computed 'players', -> @get('players').objectAt(1)

  advanceTurn: ->
    players    = @get 'players'
    players.pushObject players.shiftObject()
    @get 'activePlayer'

  hasWinner: Ember.computed 'hexes', ->
    hexes = @get 'hexes'
    player = hexes.objectAt(0).get 'ownedBy'
    hexes.every (hex) -> hex.get('ownedBy') is player

`export default Map`
