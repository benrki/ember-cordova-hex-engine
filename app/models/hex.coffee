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

    if @get 'blocked'
      false
    else if map.get('isReinforceMode')
      map.get('activePlayer') is @get('ownedBy')
    else if map.get('isAttackMode')
      map.get('activePlayer') isnt @get('ownedBy')
    else
      false


`export default Hex`
