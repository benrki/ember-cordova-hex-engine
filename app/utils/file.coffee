`
import Ember from 'ember';
import config from '../config/environment';
`

fileSystem  = null
fsReady     = false
deviceReady = false
rootPath    = null

onSuccess = (n) -> (args...) -> n null, args...
onError   = (n) -> (err)     -> n err

onDeviceReady = ->
  if cordova?.file?
    deviceReady = true
    platform    = window.device.platform

    console.info "Cordova enabled"
    console.info "Running on #{platform}"

    checkFileSystemReady (err, fs) ->
      do createDefaultDirectories unless err?
  else
    console.warn "Cordova disabled"

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
      console.info "Cordova not running" unless deviceReady

      # path =
      #   if device.platform is 'Android'
      #     cordova.file.dataDirectory
      #   else
      #     cordova.file.documentsDirectory

      # resolveLocalFileSystemURL path, (localFS) ->
      #   window.fileSystem = fileSystem = localFS

      window.fileSystem = fileSystem = fs
      fsReady           = true

      rootPath          = fileSystem.root.toURL()

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

  dir.getDirectory path, options, (dir) ->
    done null, dir
  , (err) ->
    done err

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

getFile = (name, path, done) ->
  checkFileSystemReady ->
    async.waterfall [
      (n) ->
        dir = rootPath + path
        resolveLocalFileSystemURL dir, onSuccess(n), onError(n)
      (dirEntry, n) ->
        dirEntry.getFile name, { create: true }, onSuccess(n), onError(n)
    ], done

writeFile = (name, path, data, done) ->
  getFile name, path, (err, fileEntry) ->
    fileEntry.createWriter (fw) ->
      fw.write data
      done fw.error, fw
    , onError(done)

removeFile = (name, path, done) ->
  getFile name, path, (err, fileEntry) ->
    fileEntry.remove done, onError(done)

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
    async.waterfall [
      (n) ->
        fileSystem.root.getDirectory path, null, onSuccess(n), onError(n)
      (dirEntry, n) ->
        dirReader = dirEntry.createReader()
        dirReader.readEntries onSuccess(n), onError(n)
    ], done

file = {
  checkDirectoryExists
  createDirectory
  writeFile
  removeFile
  readDirectory
}

`export default file`
