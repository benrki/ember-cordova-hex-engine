`
import Ember from 'ember';
import config from '../config/environment';
`

fileSystem  = null
fsReady     = false
deviceReady = false

onDeviceReady = ->
  if cordova?.file?
    console.info "Cordova enabled!"
    deviceReady = true
    checkFileSystemReady (err, fs) ->
      do createDefaultDirectories unless err?
  else
    console.warn "Cordova disabled!"

document.addEventListener "deviceready", onDeviceReady, false

retry = (toDo) ->
  window.setTimeout toDo, 500

checkDeviceReady = (done) ->
  if deviceReady then done() else retry -> checkDeviceReady done

requestFileSystem = (done) ->
  requestFS = window.requestFileSystem or window.webkitRequestFileSystem
  if deviceReady and not fsReady
    requestFS window.PERSISTENT, 0, (fs) ->
      console.info "FileSystem ready", fs
      window.fileSystem = fileSystem = fs
      fsReady           = true
      console.info "Cordova not running" unless deviceReady
      done null
    , (err) ->
      fsReady = false
      done err
  else
    do done

checkFileSystemReady = (done) ->
  requestFileSystem (err) ->
    if fsReady and not err?
      done()
    else
      retry ->
        checkFileSystemReady done

getDirectory = (path, options, done) ->
  dir = new DirectoryEntry null, null, fileSystem
  dir.getDirectory path, options, ((dir) -> done(null, dir)), (err) -> done(err)

checkDirectoryExists = (path, done) ->
  getDirectory path, {}, done

createDirectory = (path, done) ->
  getDirectory path, { create: true }, done

# Recursively creates all non-existing directories for a path
createDirectories = (path, done) ->
  dirs = path.split '/'

  dirs = _.map dirs, (dir, index) ->
    tempDirs = dirs.slice 0, index + 1
    _.reduce tempDirs, (path, dir) ->
      path + dir + '/'
    , ""

  async.eachSeries dirs, createDirectory, done

writeFile = (path, data, done) ->
  checkFileSystemReady ->
    path       = cordova.file.documentsDirectory + path
    fileWriter = new FileWriter path
    fileWriter.write data
    done fileWriter

createDefaultDirectories = ->
  async.each config.defaults.folders, (folder, done) ->
    createDirectories folder, done
  , (err) ->
    if err?
      console.error "Error creating default folders", err
    else
      console.info "Finished creating default folders", config.defaults.folders

readDirectory = (path, done) ->
  checkFileSystemReady ->
    dir = new DirectoryReader cordova.file.documentsDirectory + path

    dir.readEntries (res) ->
      done null, res
    , (err) ->
      done err

file = {
  checkDirectoryExists
  createDirectory
  writeFile
  readDirectory
}

`export default file`
