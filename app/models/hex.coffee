`import DS from 'ember-data'`

Hex = DS.Model.extend
  map:        DS.belongsTo 'map', { inverse: 'hexes' }
  ownedBy:    DS.belongsTo 'player'
  blocked:    DS.attr 'boolean', { defaultValue: false }
  selected:   DS.attr 'boolean', { defaultValue: false }

  resources:
    hexon: DS.attr 'number'

  coordinates:
    x: DS.attr 'number'
    y: DS.attr 'number'
    z: DS.attr 'number'

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


`export default Hex`
