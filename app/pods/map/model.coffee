`import DS from 'ember-data'`

Map = DS.Model.extend
  name:       DS.attr 'string', defaultValue: new Date().toISOString()
  hexes:      DS.hasMany 'hex'
  isDefault:  DS.attr 'boolean'
  fileName:   DS.attr 'string'
  players:    DS.hasMany 'player'

`export default Map`
