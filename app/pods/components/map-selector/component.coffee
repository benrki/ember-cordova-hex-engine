`import Ember from 'ember'`

MapSelectorComponent = Ember.Component.extend
  actions:
    clickMap: (map) ->
      @get('clickMap') map

    clickRemoveMap: (map) ->
      @get('clickRemoveMap') map

`export default MapSelectorComponent`
