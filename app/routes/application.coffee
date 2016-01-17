`import Ember from 'ember'`

ApplicationRoute = Ember.Route.extend
  actions:
    toggleNav: (show) ->
      @controller.set 'showNav', show
      false

    returnToIndex: ->
      @controller.set 'showNav', true
      @transitionTo   'index'
      false

`export default ApplicationRoute`
