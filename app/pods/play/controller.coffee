`import Ember from 'ember'`

PlayController = Ember.Controller.extend
  showControls: true
  isReinforceMode: Ember.computed 'model.mode', ->
    @get('model.mode') is "reinforce"
  isAttackMode:    Ember.computed 'model.mode', ->
    @get('model.mode') is "attack"

`export default PlayController`
