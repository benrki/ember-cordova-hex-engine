`import DS from 'ember-data'`

Map = DS.Model.extend
  name:        DS.attr    'string', defaultValue: new Date().toISOString()
  hexes:       DS.hasMany 'hex',    { inverse: 'map' }
  players:     DS.hasMany 'player', { inverse: 'map' }
  isDefault:   DS.attr    'boolean'
  fileName:    DS.attr    'string'
  mode:        DS.attr    'string', defaultValue: ""
  turnsPassed: DS.attr    'number'
  stats:       DS.attr()

  activePlayer:     Ember.computed 'players', -> @get('players').objectAt(0)
  nextPlayer:       Ember.computed 'players', -> @get('players').objectAt(1)
  player:           Ember.computed 'players.@each.isPlayer', ->
    @get('players').findBy 'isPlayer'
  isAttackMode:     Ember.computed 'mode',    -> @get('mode') is "ATTACK"
  isReinforceMode:  Ember.computed 'mode',    -> @get('mode') is "REINFORCE"

  advanceTurn: ->
    players    = @get 'players'
    players.pushObject players.shiftObject()
    @get 'activePlayer'

  hasWinner: Ember.computed 'hexes', ->
    hexes = @get 'hexes'
    player = hexes.objectAt(0).get 'ownedBy'
    hexes.every (hex) -> hex.get('ownedBy') is player

  blockedHexes: Ember.computed 'hexes.@each.blocked', ->
    @get('hexes').filterBy 'blocked'

  unblockedHexes: Ember.computed.not 'blockedHexes'

  clearSelected: ->
    hexes = @get 'hexes'
    hexes.setEach 'selected', false

`export default Map`
