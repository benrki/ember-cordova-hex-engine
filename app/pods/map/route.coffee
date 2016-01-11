`import Ember from 'ember'`

MapRoute = Ember.Route.extend
  model: -> @store.peekAll 'map'

  hideMap: (->
    @controller.set 'showMap', false
  ).on 'deactivate'

`export default MapRoute`
