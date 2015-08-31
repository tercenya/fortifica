alt = require('../alt')
API = require('../utils/AnalysisAPI')
DDragon = require('../utils/DataDragonAPI')

class ItemHierarchyActions
  constructor: ->
    this.generateActions('receiveAnalysis', 'selectPath')

  fetchAnalysis: (name) ->
    this.dispatch()

    API.fetchAnalysis(name).then( (analysis) =>
      DDragon.fetchChampion(name).then( (champion) =>
        this.actions.receiveAnalysis({ analysis: analysis, champion: champion})
      )
    )

module.exports = alt.createActions(ItemHierarchyActions)
