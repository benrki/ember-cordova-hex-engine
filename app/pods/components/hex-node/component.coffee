`import Ember from 'ember'`

{ PI, cos, sin, sqrt } = Math

HexNodeComponent = Ember.Component.extend
  tagName:   "g"
  rotation:  "rotate(0)"
  textColor: "white"

  color: Ember.computed 'isSelected', ->
    if @get('isSelected') then "orange" else "black"

  isSelected: Ember.computed 'selected', -> @get('selected') is @get('model')

  horizontalDistance: Ember.computed 'width', -> 3 / 4 * @get 'width'

  offsetX: Ember.computed 'model.coordinates.r', 'horizontalDistance', ->
    @get('model.coordinates.r') * @get('horizontalDistance')

  offsetY: Ember.computed 'model.coordinates.q', 'height', ->
    offset =
      if @get('model.coordinates.r') % 2 is 1 then @get('height') / 2 else 0
    @get('model.coordinates.q') * @get('height') + offset

  hexTransform: Ember.computed ->
    "translate(#{@get 'offsetX'},#{@get 'offsetY'})"

  width:  Ember.computed 'size', -> 2 * @get 'size'

  height: Ember.computed 'size', -> sqrt(3) / 2 * @get 'width'

  getCorner: ({ center, size }) -> (i) ->
    angleDegrees = 60 * i + 30
    angleRadians = PI / 180 * angleDegrees
    q: center.q + size * cos angleRadians
    r: center.r + size * sin angleRadians

  points: Ember.computed 'model.coordinates.q', 'model.coordinates.q', ->
    options =
      center: @get 'model.coordinates'
      size:   @get 'size'

    _.chain [0..5]
      .map @getCorner options
      .reduce (str, { q, r }) ->
        str + " #{r},#{q}"
      , ""
      .value()

  actions:
    clickNode: (hex) ->
      @set 'selected', hex

`export default HexNodeComponent`
