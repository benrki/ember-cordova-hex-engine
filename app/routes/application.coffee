`import Ember from 'ember'`

ApplicationRoute = Ember.Route.extend
  actions:
    toggleNav: (show) ->
      @controller.set 'showNav', show
      false

`export default ApplicationRoute`
