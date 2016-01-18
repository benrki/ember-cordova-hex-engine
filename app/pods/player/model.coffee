`import DS from 'ember-data'`

Player = DS.Model.extend
  map:           DS.belongsTo 'map', { inverse: 'players' }
  hexes:         DS.hasMany 'hex'
  name:          DS.attr    'string'
  score:         DS.attr    'number'
  played:        DS.attr()
  color:         DS.attr    'string'
  isPlayer:      DS.attr    'boolean'
  isAI:          Ember.computed.not 'isPlayer'

  # AI methods
  reinforce: ->
    name = @get('name')
    console.log "#{name} reinforce"

  attack: ->
    name = @get('name')
    console.log "#{name} play"

`export default Player`
