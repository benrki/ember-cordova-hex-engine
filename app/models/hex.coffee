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
    map = @get 'map'
    return false if @get 'blocked'
    @get('ownedBy').then (owner) ->
      if map.get('isReinforceMode')
        map.get('activePlayer') is owner
      else if map.get('isAttackMode')
        map.get('activePlayer') isnt owner
      else
        false


`export default Hex`
