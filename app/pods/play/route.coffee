`
import Ember from 'ember';
import config from '../../config/environment'
`

defaults = config.defaults

# TODO: return player in model hook
PlayRoute = Ember.Route.extend
  numPlayers: 3
  loading:    false

  model: ({ id }) ->
    @store.peekRecord 'map', id

  afterModel: (model, transition) ->
    if model?
      @initialize(model) (model) =>
        @renderMap model, =>
          @playGame model
    else
      @transitionTo 'map'

  # setupController: (controller, model) -> @playGame model

  initialize: (model) -> (done) =>
    @createPlayers model
    done model

  getRandomHexes: (model) -> (num) ->
    hexes       = model.get('hexes')
    totalLength = hexes.get 'length'
    getRandomHex = (i) ->
      index = _.random(0, totalLength) + (i + 1)
      totalLength--
      hexes.objectAt(index)

    _.map [0...num], getRandomHex

  createPlayer: (player, i) ->
    mapId          = @get 'id'
    players        = @get 'players'
    playerId       = "player-#{i}-#{mapId}"
    existingPlayer =
      players.findBy('id', playerId) or @store.peekRecord('player', playerId)

    if existingPlayer?
      existingPlayer
    else
      player = _.extend player,
        name:  "Player #{i}"
        id:    playerId
        score: 0
      players.pushObject @store.createRecord 'player', player

  createPlayers: (model) ->
    playerExists    = (p, i) -> model.get('players').findBy('id', "#{i}")?
    numPlayers      = @get 'numPlayers'
    playersToCreate = _.reject defaults.players[0...numPlayers], playerExists
    players         = _.map playersToCreate, @createPlayer, model
    randCoords      = @getRandomHexes(model) players.length
    _.map randCoords, (hex, i) ->
      player = players[i]
      player.set 'map', model
      hex.set 'ownedBy', player

  renderMap: (map, done) ->
    @set  'loading',   true
    @send 'toggleNav', false
    # Guarantee loader show before map is rendered
    Ember.run.next =>
      @set 'map', map
      # Wait until map is finished rendered before dismissing loader
      Ember.run.next =>
        @set 'loading', false
        do done

  startReinforce: (model) ->
    console.log "start player reinforce mode", model
    model.set 'mode', 'REINFORCE'

  startAttack: (model) ->
    model.set 'mode', 'ATTACK'

  playAI: (player, done) ->
    do player.reinforce
    Ember.run.next ->
      do player.attack
      Ember.run.next ->
        do done

  playTurn: (model) ->
    player = model.get 'activePlayer'
    console.log "play", player.get 'name'
    if player.get 'isAI'
      @playAI player, =>
        do model.advanceTurn
        @playTurn model
    else
      @startReinforce model
      # @controller.set 'showControls', true
      @controllerFor('play').set 'showControls', true

  playGame: (model) ->
    @playTurn model

  endGame: ->
    @transitionTo 'map'

  endTurn: (model) ->
    if model.get 'hasWinner'
      do @endGame
    else
      if model.get('activePlayer').get 'isPlayer'
        @controller.set 'showControls', false
        model.set 'mode', 'NONE'
      do model.advanceTurn
      @playTurn model
      model.set('turnsPassed', model.get('turnsPassed') + 1)

  actions:
    goBack:               -> @send        'returnToIndex'
    endTurn:      (model) -> @endTurn     model
    endReinforce: (model) -> @startAttack model

`export default PlayRoute`
