`import Ember from 'ember'`

HexMapComponent = Ember.Component.extend
  height: 300
  width:  300
  hexSize: 15

  transform: Ember.computed 'hexSize', ->
    "translate(#{@get 'hexSize'},#{@get 'hexSize'})"

`export default HexMapComponent`
