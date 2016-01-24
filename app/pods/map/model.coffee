`import DS from 'ember-data'`

Map = DS.Model.extend
  name:        DS.attr    'string', defaultValue: new Date().toISOString()
  hexes:       DS.hasMany 'hex',    { inverse: 'map' }
  players:     DS.hasMany 'player', { inverse: 'map' }
  isDefault:   DS.attr    'boolean'
  fileName:    DS.attr    'string'
  mode:        DS.attr    'string', defaultValue: ""
  rounds:      DS.attr    'number', defaultValue: 0
  stats:       DS.attr()
  previousSelected: DS.attr()

  activePlayer:     Ember.computed 'players', -> @get('players').objectAt(0)
  nextPlayer:       Ember.computed 'players', -> @get('players').objectAt(1)
  player:           Ember.computed 'players.@each.isPlayer', ->
    @get('players').findBy 'isPlayer'
  isAttackMode:     Ember.computed 'mode',    -> @get('mode') is "ATTACK"
  isReinforceMode:  Ember.computed 'mode',    -> @get('mode') is "REINFORCE"
  gameStarted:      Ember.computed.bool 'rounds'

  advanceTurn: ->
    players = @get 'players'
    hexes   = @get 'hexes'
    players.pushObject players.shiftObject()
    @get 'activePlayer'

  hasWinner: Ember.computed 'hexes.@each.ownedBy', ->
    player = @get('activePlayer')
    Ember.RSVP.filter(@get('owners').toArray(), (o) -> o?).then (owners) ->
      owners.every (o) -> o is player

  owners: Ember.computed.mapBy 'hexes', 'ownedBy'

  blockedHexes:   Ember.computed.filterBy 'hexes', 'blocked'
  unblockedHexes: Ember.computed.not 'blockedHexes'

  clearSelected: ->
    hexes = @get 'hexes'
    prev  = hexes.findBy('selected')
    if prev?
      @set 'previousSelected', prev
      prev.set 'selected', false

  endRound: ->
    @incrementProperty 'rounds'

`export default Map`
