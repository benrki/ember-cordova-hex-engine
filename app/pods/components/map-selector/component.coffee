`import Ember from 'ember'`

MapSelectorComponent = Ember.Component.extend
  actions:
    load:   (map) -> @sendAction 'loadMap',   map
    remove: (map) -> @sendAction 'removeMap', map

`export default MapSelectorComponent`
