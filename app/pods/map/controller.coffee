`
import Ember from 'ember';
import config from '../../config/environment';
import file from '../../utils/file';
`

defaults = config.defaults.map

MapController = Ember.Controller.extend
  actions:
    goToMap: (map) ->
      @transitionToRoute 'play', map

    removeMap: (map) ->
      file.removeFile map.get('fileName'), defaults.path, (res) =>
        if res? and res isnt 'OK'
          console.error "Error removing map", err
        else
          @store.deleteRecord map
          @set 'map', null
          console.log "Finished removing map"

`export default MapController`
