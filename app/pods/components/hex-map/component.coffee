`
import Ember from 'ember';
import config from '../../../config/environment';
`

{ sqrt } = Math

HexMapComponent = Ember.Component.extend
  hexSize:   config.defaults.hex.size
  hexWidth:  Ember.computed 'hexSize',   -> 2 * @get 'hexSize'
  hexHeight: Ember.computed 'hexSize',   -> sqrt(3) * @get('hexSize')
  offsetX:   Ember.computed 'hexWidth',  -> @get('hexWidth') / 2
  offsetY:   Ember.computed 'hexHeight', -> @get('hexHeight') / 2

  width: Ember.computed 'hexSize', ->
    numWidth = sqrt @get 'model.hexes.length'
    width    = @get 'hexWidth'
    width + width * 3/4 * numWidth

  height: Ember.computed 'hexSize', ->
    numHeight = sqrt @get 'model.hexes.length'
    height    = @get 'hexHeight'
    height + height * numHeight + height / 2

  transform: Ember.computed 'hexSize', ->
    "translate(#{@get 'offsetX'},#{@get 'offsetY'})"

`export default HexMapComponent`
