`import Ember from 'ember'`

PlayRoute = Ember.Route.extend
  loading: false

  model: ({ id }) ->
    @store.peekRecord 'map', id

  renderMap: (map) ->
    @set 'loading',    true
    @send 'toggleNav', false
    # Guarantee loader show before map is rendered
    Ember.run.next =>
      @set 'map', map
      # Wait until map is finished rendered before dismissing loader
      Ember.run.next =>
        @set 'loading', false

  afterModel: (model, transition) ->
    @renderMap model

`export default PlayRoute`
