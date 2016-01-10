`import Ember from 'ember'`

MapSelectorComponent = Ember.Component.extend
  actions:
    load:   (map) -> @sendAction 'renderMap', map
    remove: (map) -> @sendAction 'removeMap', map

`export default MapSelectorComponent`
