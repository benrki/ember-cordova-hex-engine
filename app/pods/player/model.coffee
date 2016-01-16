`import DS from 'ember-data'`

Player = DS.Model.extend
  maps:   DS.hasMany 'map'
  name:   DS.attr 'string'
  score:  DS.attr 'number'
  played: DS.attr()
  color:  DS.attr 'string'

`export default Player`
