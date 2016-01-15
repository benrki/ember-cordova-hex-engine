`
import config from '../config/environment';
`

defaults = config.defaults.map

initialize = (appInstance) ->
  store = appInstance.lookup 'service:store'
  file  = appInstance.lookup 'service:file'

  loadMap = (file, done) ->
    reader = new FileReader()

    reader.onloadend = (evt) ->
      console.info 'Loading map', file.name
      mapData = JSON.parse evt.target.result
      hexes   = mapData.hexes
      delete mapData.hexes

      map = store.createRecord 'map', mapData
      store.createRecord 'hex', _.extend hex, { map: map } for hex in hexes

      do done

    reader.readAsText(file)

  loadMaps = ->
    file.readDirectory defaults.path, (err, dirContents) ->
      if err?
        console.error "Error reading maps directory", err
        return err

      nameEndsWith = (name, substr) ->
        name.indexOf(substr) is name.length - substr.length

      isMapFile = (entry) ->
        entry.isFile and nameEndsWith entry.name, defaults.fileType

      load = (entry, done) ->
        entry.file (file) ->
          loadMap file, done
        , (err) ->
          console.error "Failed to load file", entry, err
          done err

      mapsToLoad = _.filter dirContents, isMapFile

      async.each mapsToLoad, load, (err) ->
        return console.error "Error loading map(s)", err if err?
        console.info "Loaded #{mapsToLoad.length} map(s)"

  do loadMaps

MapInitializer =
  name: 'map'
  initialize: initialize

`export {initialize}`
`export default MapInitializer`