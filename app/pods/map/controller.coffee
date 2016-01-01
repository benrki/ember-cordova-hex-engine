`
import Ember from 'ember';
import config from '../../config/environment';
import file from '../../utils/file';
`

defaults = config.defaults.map

MapController = Ember.Controller.extend
  map:     null
  showMap: false
  loading: false

  loadMap: (map) ->
    @set 'loading', true
    @set 'showMap', false
    @set 'map',     null

    @set 'map',     map

    @set 'loading', false
    @set 'showMap', true

  removeMap: (map) ->
    console.log "Removing map", map
    file.removeFile map.get('fileName'), defaults.path, (res) =>
      if res? and res isnt 'OK'
        console.error "Error removing map", err
      else
        @store.deleteRecord map
        @set 'map', null
        console.log "Finished removing map"

  actions:
    clickMap:       (map) -> @loadMap map
    clickRemoveMap: (map) -> @removeMap map

`export default MapController`
