`
import Ember   from 'ember';
import config  from '../../config/environment';
import hex     from '../../utils/hex';
import shortid from 'npm:shortid';
`

{ ceil, random } = Math

defaults = config.defaults.map

MapGeneratorController = Ember.Controller.extend
  sizes: defaults.sizes
  size:  defaults.size
  file:  Ember.inject.service 'file'

  actions:
    generateMap: (e) ->
      hexes   = []
      hexJSON = []

      randResource = ->
        _.find [defaults.resources.max..1], (v) -> random() <= 1/v

      console.info "Generating map of size: #{@size.size}"

      mapName  = new Date().toString()
      fileName = encodeURIComponent(mapName) + defaults.fileType

      map = @store.createRecord 'map',
        id:        shortid.generate()
        name:      mapName
        isDefault: false
        fileName:  fileName

      for q in [0...@size.size]
        for r in [0...@size.size]
          resource = randResource()
          hexData =
            coordinates: { q, r }
            resources:
              reinforce: resource
              current:   resource
          hexJSON.push hexData
          hexes.push @store.createRecord 'hex', hexData

      map.get('hexes').pushObjects hexes
      mapData = JSON.stringify _.extend map.toJSON(),
        { hexes: hexJSON, id: map.get('id') }

      @get('file').writeFile fileName, defaults.path, mapData, (err, fw) ->
        if err?
          console.error 'Error writing save to file', err
        else
          console.info "Successfully generated map", map.toJSON(), fw.localURL

`export default MapGeneratorController`
