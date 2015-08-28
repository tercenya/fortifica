alt = require('../alt')
API = require('../utils/DataDragonAPI')

class ChampionActions
  constructor: ->
    this.generateActions('receiveChampions')

  fetchChampions: ->
    this.dispatch()

    API.fetchChampions().then( (championData) =>
      this.actions.receiveChampion(championData)
    )

module.exports = alt.createActions(ChampionActions)
