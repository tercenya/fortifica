_ = require('lodash')
alt = require('../alt')
ChampionActions = require('../actions/ChampionActions')

class ChampionStore
  constructor: ->
    this.isLoading = true
    this.champions = []

    this.bindActions(ChampionActions)

  onReceiveChampions: (championData) ->
    this.isLoading = false
    this.champions = _.values(championData.data)

module.exports = alt.createStore(ChampionStore, 'ChampionStore')
