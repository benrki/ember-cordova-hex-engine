`
import file from '../utils/file';
import config from '../config/environment';
`

defaults = config.defaults.map

initialize = (appInstance) ->
  store = appInstance.lookup 'service:store'

  loadMap = (file, done) ->
    reader = new FileReader()

    reader.onloadend = (evt) ->
      console.info 'Loading map', file.name

      fullName = decodeURIComponent file.name
      name     = fullName.substr 0, fullName.length - defaults.fileType.length
      hexes    = JSON.parse evt.target.result

      store.createRecord 'map',
        name:  name
        hexes: hexes
        size:  hexes.length
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

  loadMaps()

MapInitializer =
  name: 'map'
  initialize: initialize

`export {initialize}`
`export default MapInitializer`