`
import DS from 'ember-data';
import util from '../utils/hex';
`

Hex = DS.Model.extend
  map:        DS.belongsTo 'map', { inverse: 'hexes' }
  ownedBy:    DS.belongsTo 'player'
  blocked:    DS.attr 'boolean', { defaultValue: false }
  selected:   DS.attr 'boolean', { defaultValue: false }

  resource:
    reinforce: DS.attr 'number'
    current: DS.attr 'number'

  coordinates:
    q: DS.attr 'number'
    r: DS.attr 'number'

  selectable: Ember.computed 'map.mode', 'blocked', ->
    map     = @get 'map'
    player  = map.get 'activePlayer'
    blocked = @get 'blocked'

    @get('ownedBy').then (owner) ->
      return false if blocked
      if map.get('isReinforceMode')
        player is owner
      else if map.get('isAttackMode')
        player isnt owner
      else
        false

  select: -> @get('selectable').then (s) => @set 'selected', s

  neighbours: Ember.computed 'coordinates', ->
    util.getNeighboursAxial @get('coordinates')

  isAdjacentTo: (hex) ->
    _.any @get('neighbours'), (n) -> _.isEqual n, hex.get('coordinates')


`export default Hex`
