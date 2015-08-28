_ = require('lodash')
React = require('react')

ItemHierarchyStore = require('../stores/ItemHierarchyStore')
ItemHierarchyActions = require('../actions/ItemHierarchyActions')

MasterTemplate = require('./MasterTemplate')

class ItemHierarchy extends React.Component
  constructor: (props) ->
    super(props)
    this.state = ItemHierarchyStore.getState()

  componentDidMount: =>
    ItemHierarchyStore.listen(this.onChange)
    ItemHierarchyActions.fetchChampion(this.props.params.name)

  componentWillUnmount: =>
    ItemHierarchyStore.unlisten(this.onChange)

  onChange: (store) =>
    this.setState(store)

  render: ->
    if this.state.isLoading
      return <p>Loading</p> # <Spinner />

    champion = this.state.champion

    return(
      <MasterTemplate>
        <section>
          {champion.name}
        </section>

      </MasterTemplate>
    )

module.exports = ItemHierarchy
