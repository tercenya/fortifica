alt = require('../alt')
API = require('../utils/DataDragonAPI')

class ItemHierarchyActions
  constructor: ->
    this.generateActions('receiveChampion')

  fetchChampion: (name) ->
    this.dispatch()

    API.fetchChampions().then( (championData) =>
      champion = championData.data[name]
      this.actions.receiveChampion(champion)
    )

module.exports = alt.createActions(ItemHierarchyActions)
