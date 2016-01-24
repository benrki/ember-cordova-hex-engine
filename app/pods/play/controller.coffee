`import Ember from 'ember'`

PlayController = Ember.Controller.extend
  showControls: true
  isReinforceMode: Ember.computed 'model.mode', ->
    @get('model.mode') is "reinforce"
  isAttackMode:    Ember.computed 'model.mode', ->
    @get('model.mode') is "attack"
  reinforcements: Ember.computed.alias 'model.player.reinforcements'

  actions:
    hexAction: (hex) ->
      model  = @get 'model'
      hex    = model.get('hexes').findBy 'selected'
      player = model.get 'activePlayer'

      if model.get('isAttackMode')
        prev = model.get('previousSelected')
        prev.get('ownedBy').then (o1) ->
          hex.get('ownedBy').then (o2) ->
            if o1 is player and o2 isnt player
              player.get('attack') prev, hex

      else if model.get('isReinforceMode')
        # TODO: UI to pick increment
        hex.get('ownedBy').then (o) ->
          player.reinforce hex, 1 if o is player


`export default PlayController`
