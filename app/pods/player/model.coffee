`import DS from 'ember-data'`

Player = DS.Model.extend
  maps:          DS.hasMany 'map', { inverse: 'players' }
  name:          DS.attr 'string'
  score:         DS.attr 'number'
  played:        DS.attr()
  color:         DS.attr 'string'
  isPlayer:    DS.attr    'boolean'

  isAI: Ember.computed.not 'isPlayer'


`export default Player`
