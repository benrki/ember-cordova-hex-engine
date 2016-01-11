`import Ember from 'ember';
import config from './config/environment';`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @route 'map'
  @route 'map-generator'

`export default Router;`
