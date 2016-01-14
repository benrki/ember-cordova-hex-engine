import Ember from 'ember';
import { initialize } from '../../../instance-initializers/map';
import { module, test } from 'qunit';

module('Unit | Instance Initializer | map', {
  beforeEach: function() {
    Ember.run(function() {
      this.application = Ember.Application.create();
      this.appInstance = this.application.buildInstance();
    });
  },
  afterEach: function() {
    Ember.run(this.appInstance, 'destroy');
    this.application.destroyApp(this.application);
  }
});

// Replace this with your real tests.
test('it works', function(assert) {
  initialize(this.appInstance);

  // you would normally confirm the results of the initializer here
  assert.ok(true);
});
