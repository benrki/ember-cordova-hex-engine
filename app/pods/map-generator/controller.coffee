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
  size:  sizes[4]

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

      file.writeFile encodeURIComponent(map.get('name')), path,
      JSON.stringify(data), (err, fw) ->
        if err?
          console.error 'Error writing save to file', err
        else
          console.log "Successfully generated map",
            map.serialize().data.attributes,
            fw.localURL

`export default MapGeneratorController`
