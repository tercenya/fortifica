_ = require('lodash')
alt = require('../alt')
ItemHierarchyActions = require('../actions/ItemHierarchyActions')

class ItemHierarchyStore
  constructor: ->
    this.isLoading = true
    this.champion = undefined

    this.bindActions(ItemHierarchyActions)

  onReceiveChampion: (championData) ->
    this.isLoading = false
    this.champion = championData

module.exports = alt.createStore(ItemHierarchyStore, 'ItemHierarchyStore')
