#!/bin/sh

nvm use

ember g cordova-init com.dev.hex

ember cordova platform add android
ember cordova plugin add cordova-plugin-file@4.0.0
