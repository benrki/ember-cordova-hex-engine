`
import Ember from 'ember';
import config from '../config/environment';
`

fileSystem  = null
fsReady     = false
deviceReady = false
rootPath    = null

onDeviceReady = ->
  if cordova?.file?
    deviceReady = true
    platform    = window.device.platform

    console.info "Cordova enabled!"
    console.info "Running on #{platform}"

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
    console.log "created dir", dir
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

writeFile = (name, path, data, done) ->
  checkFileSystemReady ->
    onSuccess = (n) -> (args...) -> n null, args...
    onError   = (n) -> (err)     -> n err

    async.waterfall [
      (n) ->
        dir = rootPath + path
        resolveLocalFileSystemURL dir, onSuccess(n), onError(n)
      (dirEntry, n) ->
        dirEntry.getFile name, { create: true }, onSuccess(n), onError(n)
      (fileEntry, n) ->
        fileEntry.createWriter (fw) ->
          fw.write data
          n fw.error, fw
    ], done

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
    console.log "reading dir", rootPath + path
    dir = new DirectoryReader rootPath + path

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
