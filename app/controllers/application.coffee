`import Ember from 'ember'`

ApplicationController = Ember.Controller.extend
  showNav: true

  actions:
    goBack: ->
      @set 'showNav', true
      @transitionToRoute 'index'

    goToRoute: (route) -> @transitionToRoute route

`export default ApplicationController`
