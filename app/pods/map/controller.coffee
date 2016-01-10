`
import Ember from 'ember';
import config from '../../config/environment';
import file from '../../utils/file';
`

defaults = config.defaults.map

MapController = Ember.Controller.extend
  loading: false
  showMap: false

  actions:
    renderMap: (map) ->
      @set 'loading', true
      @set 'showMap', false
      # Guarantee loader show before map is rendered
      Ember.run.next =>
        @set 'map', map
        # Wait until map is finished rendered before dismissing loader
        Ember.run.next =>
          @set 'showMap', true
          @set 'loading', false

    removeMap: (map) ->
      console.log "Removing map", map
      file.removeFile map.get('fileName'), defaults.path, (res) =>
        if res? and res isnt 'OK'
          console.error "Error removing map", err
        else
          @store.deleteRecord map
          @set 'map', null
          console.log "Finished removing map"

`export default MapController`
