`
import Ember from 'ember';
import config from '../../config/environment'
`

defaults = config.defaults

# TODO: return player in model hook
PlayRoute = Ember.Route.extend
  numPlayers: 3
  loading:    false

  model: ({ id }) -> @store.peekRecord 'map', id

  afterModel: (model, transition) ->
    if model?
      @initialize model, =>
        @renderMap model, => @playTurn model
    else
      @transitionTo 'map'

  initialize: (model, done) ->
    unless model.get 'gameStarted'
      model.incrementProperty 'rounds', 1
      @createPlayers model
    done model

  getRandomHexes: (model) -> (num) ->
    hexes       = model.get 'hexes'
    totalLength = hexes.get 'length'
    getRandomHex = (i) ->
      index = _.random(0, totalLength) + i
      totalLength--
      hexes.objectAt(index)

    _.map [0...num], getRandomHex

  createPlayer: (player, i) ->
    mapId          = @get 'id'
    players        = @get 'players'
    playerId       = "player-#{i}-#{mapId}"
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
    model.set 'mode', 'REINFORCE'
    player = model.get 'activePlayer'
    player.replenishReinforce()

  startAttack: (model) ->
    model.set 'mode', 'ATTACK'

  playAI: (player, done) ->
    do player.reinforceAI
    Ember.run.next ->
      do player.attackAI
      Ember.run.next ->
        do done

  playTurn: (model) ->
    player = model.get 'activePlayer'
    hexes  = model.get 'hexes'

    hexes.forEach (h) -> h.get('ownedBy').then (o) ->
      h.incrementProperty 'resources.current' if o is player

    if player.get 'isAI'
      @playAI player, =>
        do model.advanceTurn
        @playTurn model
    else
      @startReinforce model
      @controllerFor('play').set 'showControls', true

  endGame: ->
    console.info "Game won!"
    @send 'toggleNav', true
    @transitionTo 'map'

  endTurn: (model) ->
    model.get('hasWinner').then (win) =>
      if win
        @endGame()
      else
        if model.get('activePlayer').get 'isPlayer'
          @controller.set 'showControls', false
          model.set 'mode', 'NONE'
        do model.advanceTurn
        @playTurn model
        model.endRound()
        console.info "End of turn", model.get 'rounds'

  actions:
    goBack:               -> @send        'returnToIndex'
    endTurn:      (model) -> @endTurn     model
    endReinforce: (model) -> @startAttack model

`export default PlayRoute`
