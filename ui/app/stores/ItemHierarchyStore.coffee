_ = require('lodash')
alt = require('../alt')
ItemHierarchyActions = require('../actions/ItemHierarchyActions')

class ItemHierarchyStore
  constructor: ->
    this.isLoading = true
    this.champion = undefined
    this.analysis = undefined

    this.bindActions(ItemHierarchyActions)

  onReceiveAnalysis: (payload) ->
    this.isLoading = false
    this.champion = payload.champion
    this.analysis = payload.analysis

module.exports = alt.createStore(ItemHierarchyStore, 'ItemHierarchyStore')
