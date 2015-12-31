`
import Ember from 'ember';
import config from '../../config/environment';
import file from '../../utils/file'
`

defaults = config.defaults.map
sizes    = defaults.sizes
path     = defaults.path

MapGeneratorController = Ember.Controller.extend
  sizes: sizes
  size:  sizes[0]

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

      map = @store.createRecord 'map',
        hexes: data
        name:  new Date().toISOString()
        size:  data.length

      console.log "file", file
      file.writeFile "#{path}/#{map.get 'name'}", JSON.stringify(data), (fw) ->
        console.log "map generated", map.serialize().data.attributes, fw, data

`export default MapGeneratorController`
