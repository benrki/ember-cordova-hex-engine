`
import Ember from 'ember';
import config from '../../config/environment';
`

defaults = config.defaults.map

MapController = Ember.Controller.extend
  file: Ember.inject.service 'file'

  actions:
    goToMap: (map) ->
      @transitionToRoute 'play', map

    removeMap: (map) ->
      @get('file').removeFile map.get('fileName'), defaults.path, (res) =>
        if res? and res isnt 'OK'
          console.error "Error removing map", err
        else
          @store.deleteRecord map
          @set 'map', null
          console.info "Finished removing map"

`export default MapController`
