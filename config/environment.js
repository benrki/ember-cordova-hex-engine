/* jshint node: true */
defaults              = require('./default');
contentSecurityPolicy = require('./security');

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'hex',
    podModulePrefix: 'hex/pods',
    environment: environment,
    baseURL: '/',
    locationType: 'hash',
    defaultLocationType: 'auto',
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    },

    cordova: {
      rebuildOnChange: false,
      emulate: false,
      // Change/remove if not Android
      emberUrl: 'http://10.0.2.2:4200',
      liveReload: {
        enabled: true,
        platform: 'android'
      }
    },

    contentSecurityPolicy: contentSecurityPolicy,

    defaults: defaults
  };

  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    ENV.APP.LOG_VIEW_LOOKUPS = true;
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.baseURL = '/';
    ENV.locationType = 'none';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';
  }

  if (environment === 'production') {

  }

  return ENV;
};
