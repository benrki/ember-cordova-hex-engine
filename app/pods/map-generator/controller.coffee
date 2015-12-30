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

      console.log "Generating map of size: #{@size.size}"
      for x in [0...@size.size]
        for y in [0...@size.size]
          for z in [0...@size.size]
            data.push
              position: { x, y, z }
              resources:
                hexon: randInterval 0, 10

      map = @store.createRecord 'map',
        hexes: data
        name:  new Date().toISOString()
        size:  @size.size

      console.log "file", file
      file.writeFile "#{path}/#{map.get 'name'}", JSON.stringify(data), (fw) ->
        console.log "map generated", map.serialize().data.attributes, fw

`export default MapGeneratorController`
