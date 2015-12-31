`import Ember from 'ember'`

MapController = Ember.Controller.extend
  actions:
    clickMap: (map) ->
      console.log "clicked map controller", map.toJSON()

`export default MapController`
