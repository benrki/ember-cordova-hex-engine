`import Ember from 'ember'`

MapRoute = Ember.Route.extend
  model: -> @store.peekAll 'map'

`export default MapRoute`
