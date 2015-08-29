alt = require('../alt')
API = require('../utils/DataDragonAPI')

class ChampionActions
  constructor: ->
    this.generateActions('receiveChampions')

  fetchChampions: ->
    this.dispatch()

    API.fetchChampions().then( (championData) =>
      this.actions.receiveChampions(championData)
    )

module.exports = alt.createActions(ChampionActions)
