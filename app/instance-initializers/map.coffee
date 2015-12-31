`
import file from '../utils/file';
import config from '../config/environment';
`

defaults = config.defaults.map
path     = defaults.path

initialize = (appInstance) ->
  store = appInstance.lookup 'service:store'
  loadMap = (file, done) ->
    reader = new FileReader()

    reader.onloadend = (evt) ->
      console.info 'loading map', file.name
      hexes = JSON.parse evt.target.result
      store.createRecord 'map',
        name:  file.name
        hexes: hexes
        size:  hexes.length
      do done

    reader.readAsText(file)

  loadMaps = ->
    file.readDirectory path, (err, contents) ->
      load = (entry, done) ->
        if entry.isFile and entry.name isnt '.DS_Store'
          entry.file (file) ->
            loadMap file, done
          , (err) ->
            console.error "Failed to load map", err
            done err
        else
          do done

      async.each contents, load, (err) -> console.info "Loaded maps" unless err?

  loadMaps()

MapInitializer =
  name: 'map'
  initialize: initialize

`export {initialize}`
`export default MapInitializer`