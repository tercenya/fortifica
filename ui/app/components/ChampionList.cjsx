_ = require('lodash')
React = require('react')
ChampionStore = require('../stores/ChampionStore')
ChampionActions = require('../actions/ChampionActions')

Champion = require('./Champion')

class ChampionList extends React.Component
  constructor: (props) ->
    super(props)
    this.state = ChampionStore.getState()

  componentDidMount: =>
    ChampionStore.listen(this.onChange)
    ChampionActions.fetchChampions()

  componentWillUnmount: =>
    ChampionActions.unlisten(this.onChange)

  onChange: (store) =>
    this.setState(store)

  render: ->
    if this.state.isLoading
      return <p>Loading</p> # <Spinner />

    console.log(this.state.champions)
    championList = this.state.champions.map (e) ->
      <Champion champion={e} key={e.id} />

    return(
      <ul className='champion-list'>{championList}</ul>
    )

module.exports = ChampionList
