`
import Ember from 'ember'
`

MapGeneratorController = Ember.Controller.extend
  actions:
    generateMap: (e) ->
      data = []
      randInterval = (max, min) ->
        Math.ceil Math.random() * (max - min) + min
      for x in [0...100]
        console.log "percent finished #{x}%"
        for y in [0...100]
          for z in [0...100]
            data.push
              position: { x, y, z }
              resources:
                hexon: randInterval 0, 10
      map = @store.createRecord 'map',
        hexes: data
      console.log "map generated", map

`export default MapGeneratorController`
