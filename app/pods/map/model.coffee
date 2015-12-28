`import DS from 'ember-data'`

Map = DS.Model.extend
  name: DS.attr 'string', defaultValue: new Date().toISOString()
  hexes: DS.attr()

`export default Map`
