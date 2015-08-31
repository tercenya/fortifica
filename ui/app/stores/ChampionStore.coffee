_ = require('lodash')
alt = require('../alt')
ChampionActions = require('../actions/ChampionActions')

class ChampionStore
  constructor: ->
    this.isLoading = true
    this.champions = []
    this.championMap = {}

    this.bindActions(ChampionActions)

  onReceiveChampions: (championData) ->
    this.isLoading = false
    this.championMap = championData.data
    this.champions = _.values(this.championMap)

module.exports = alt.createStore(ChampionStore, 'ChampionStore')
