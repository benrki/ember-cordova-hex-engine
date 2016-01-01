`
import Ember from 'ember';
import config from '../../config/environment';
import file from '../../utils/file'
`

defaults = config.defaults.map

MapGeneratorController = Ember.Controller.extend
  sizes: defaults.sizes
  size:  defaults.size

  actions:
    generateMap: (e) ->
      data = []

      randInterval = (max, min) ->
        Math.ceil Math.random() * (max - min) + min

      console.log "Generating map of size: #{Math.pow(@size.size * 2, 2)}"

      for x in [-@size.size...@size.size]
        for y in [-@size.size...@size.size]
          data.push
            position: { x, y }
            resources:
              hexon: randInterval 0, 10

      mapName = new Date().toISOString()
      fileName = encodeURIComponent(mapName) + defaults.fileType

      map = @store.createRecord 'map',
        hexes:     data
        name:      mapName
        size:      data.length
        isDefault: false
        fileName:  fileName

      file.writeFile fileName, defaults.path, JSON.stringify(data), (err, fw) ->
        if err?
          console.error 'Error writing save to file', err
        else
          console.log "Successfully generated map",
            map.serialize().data.attributes,
            fw.localURL

`export default MapGeneratorController`
