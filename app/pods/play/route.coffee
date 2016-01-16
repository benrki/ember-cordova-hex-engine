`
import Ember from 'ember';
import config from '../../config/environment'
`

defaults = config.defaults

PlayRoute = Ember.Route.extend
  numPlayers: 3
  loading: false

  model: ({ id }) ->
    @store.peekRecord 'map', id

  afterModel: (model, transition) ->
    if model?
      @initialize(model) (model) =>
        @renderMap model
    else
      @transitionTo 'index'

  initialize: (model) -> (done) =>
    @createPlayers model
    do done

  getRandomHexes: (model) -> (num) ->
    hexes       = model.get('hexes')
    totalLength = hexes.get 'length'
    getRandomHex = (i) ->
      index = _.random(0, totalLength) + (i + 1)
      totalLength--
      hexes.objectAt(index)

    _.map [0...num], getRandomHex

  createPlayer: (player, i) ->
    players = @get 'players'
    existingPlayer  = players.findBy('id', i) or @store.peekRecord('player', i)

    if existingPlayer?
      existingPlayer
    else
      player = _.extend player,
        name:  "Player #{i}"
        id:    i
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
      console.log "player", player.get('maps')
      player.get('maps').pushObject model
      hex.set 'ownedBy', player

  renderMap: (map) ->
    @set  'loading',   true
    @send 'toggleNav', false
    # Guarantee loader show before map is rendered
    Ember.run.next =>
      @set 'map', map
      # Wait until map is finished rendered before dismissing loader
      Ember.run.next =>
        @set 'loading', false

`export default PlayRoute`
