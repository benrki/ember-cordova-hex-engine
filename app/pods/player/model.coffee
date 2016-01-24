`import DS from 'ember-data'`

Player = DS.Model.extend
  map:            DS.belongsTo 'map', { inverse: 'players' }
  hexes:          DS.hasMany 'hex'
  name:           DS.attr    'string'
  score:          DS.attr    'number'
  played:         DS.attr()
  color:          DS.attr    'string'
  isPlayer:       DS.attr    'boolean'
  reinforcements: DS.attr 'number'
  isAI:           Ember.computed.not 'isPlayer'

  reinforce: (hex, i) ->
    if @get('reinforcements') >= i
      @decrementProperty 'reinforcements', i
      hex.incrementProperty 'resources.hexon', i
      true
    else
      false

  attack: (source, target) ->
    sourceHex = source.get 'resources.hexon'
    targetHex = target.get 'resources.hexon'

    if sourceHex > targetHex
      target.set 'resources.hexon', 0
      source.decrementProperty 'resources.hexon', targetHex
      target.set 'ownedBy', source.get 'ownedBy'
    else
      target.decrementProperty 'resources.hexon', sourceHex
      source.set 'resources.hexon', 0

  reinforceAI: -> console.log "AI reinforce"

  attackAI: -> console.log "AI attack"

  replenishReinforce: -> @set 'reinforcements', @get('totalReinforce')

  totalReinforce: Ember.computed 'hexes.[]', 'hexes.@each.resources.hexon', ->
    @get('hexes').reduce ((total, hex) -> total + hex.get('resources.hexon')), 0

`export default Player`
