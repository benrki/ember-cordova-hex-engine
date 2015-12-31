`import Ember from 'ember'`

MapSelectorComponent = Ember.Component.extend
  actions:
    clickMap: (map) ->
      @get('clickMap') map

`export default MapSelectorComponent`
