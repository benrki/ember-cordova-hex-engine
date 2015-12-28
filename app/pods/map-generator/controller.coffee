`
import Ember from 'ember';
import config from '../../config/environment';
`

sizes = config.defaults.map.sizes

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
        console.log "percent finished #{x}%"
        for y in [0...@size.size]
          for z in [0...@size.size]
            data.push
              position: { x, y, z }
              resources:
                hexon: randInterval 0, 10

      map = @store.createRecord 'map',
        hexes: data

      console.log "map generated", map.serialize().data.attributes

`export default MapGeneratorController`
