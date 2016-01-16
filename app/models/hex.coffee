`import DS from 'ember-data'`

Hex = DS.Model.extend
  map:          DS.belongsTo 'map'
  controlledBy: DS.belongsTo 'player'

  resources:
    hexon: DS.attr 'number'

  coordinates:
    x: DS.attr 'number'
    y: DS.attr 'number'
    z: DS.attr 'number'


`export default Hex`
