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
    console.log "#{name} reinforce #{@get('reinforcements')}"

  attack: ->
    name = @get('name')
    console.log "#{name} play"

  reinforcements: Ember.computed 'hexes.[]', ->
    @get('hexes').reduce ((total, hex) -> total + hex.get('resources.hexon')), 0

`export default Player`
