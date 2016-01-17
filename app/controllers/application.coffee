`import Ember from 'ember'`

ApplicationController = Ember.Controller.extend
  showNav: true

  actions:
    goToRoute: (route) -> @transitionToRoute route

`export default ApplicationController`
