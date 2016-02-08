`import DS from 'ember-data'`

Player = DS.Model.extend
  map:            DS.belongsTo 'map', { inverse: 'players' }
  hexes:          DS.hasMany 'hex'
  name:           DS.attr    'string'
  score:          DS.attr    'number'
  played:         DS.attr()
  color:          DS.attr    'string'
  isPlayer:       DS.attr    'boolean'
  reinforcements: DS.attr    'number'
  order:          DS.attr    'number'
  isAI:           Ember.computed.not 'isPlayer'

  reinforce: (hex, i) ->
    if @get('reinforcements') >= i
      @decrementProperty 'reinforcements', i
      hex.incrementProperty 'resources.current', i
      true
    else
      false

  attack: (source, target) ->
    sourceHex = source.get 'resources.current'
    targetHex = target.get 'resources.current'

    if sourceHex >= targetHex
      target.set 'resources.current', sourceHex - targetHex
      source.set 'resources.current', 0
      target.set 'ownedBy', source.get 'ownedBy'
    else
      target.set 'resources.current', targetHex - sourceHex
      source.set 'resources.current', 0

  reinforceAI: ->
    console.log "AI reinforce", @get 'name'

  attackAI: ->
    console.log "AI attack", @get 'name'

  replenishReinforce: ->
    @set 'reinforcements', @get('hexes').reduce ((total, hex) ->
      total + hex.get('resources.reinforce') - 1), 0

`export default Player`
