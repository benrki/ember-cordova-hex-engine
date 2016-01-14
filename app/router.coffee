`import Ember from 'ember';
import config from './config/environment';`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @route 'map'
  @route 'map-generator'
  @route 'settings'
  @route 'player'
  @route 'play', { path: '/play/:id' }

`export default Router;`
