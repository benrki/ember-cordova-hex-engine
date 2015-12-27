`import Ember from 'ember';
import config from './config/environment';`

Router = Ember.Router.extend
  location: config.defaultLocationType

Router.map ->
  @route 'map'

`export default Router;`
