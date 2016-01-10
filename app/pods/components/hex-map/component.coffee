`import Ember from 'ember'`

{ sqrt } = Math

HexMapComponent = Ember.Component.extend
  hexSize: 15

  hexWidth: Ember.computed 'hexSize', ->
    2 * @get 'hexSize'

  hexHeight: Ember.computed 'hexSize', ->
    sqrt(3) * @get 'hexSize'

  height: Ember.computed 'hexSize', ->
    offset = @get('hexHeight') / 2
    offset + sqrt(@get('model.hexes.length')) * @get('hexHeight')

  width: Ember.computed 'hexSize', ->
    offset = @get('hexWidth') / 2
    offset + sqrt(@get('model.hexes.length')) * @get('hexWidth')

  transform: Ember.computed 'hexSize', ->
    "translate(#{@get('hexHeight') / 2},#{@get('hexWidth') / 2})"

`export default HexMapComponent`
