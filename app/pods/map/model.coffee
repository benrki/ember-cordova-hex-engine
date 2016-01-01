`import DS from 'ember-data'`

Map = DS.Model.extend
  name:      DS.attr 'string', defaultValue: new Date().toISOString()
  hexes:     DS.attr()
  size:      DS.attr 'number'
  isDefault: DS.attr 'boolean'
  fileName:  DS.attr 'string'

`export default Map`
