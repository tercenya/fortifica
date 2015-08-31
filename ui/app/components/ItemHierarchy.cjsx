_ = require('lodash')
React = require('react')

ItemHierarchyStore = require('../stores/ItemHierarchyStore')
ItemHierarchyActions = require('../actions/ItemHierarchyActions')

MasterTemplate = require('./MasterTemplate')
ItemExplorer = require('./ItemExplorer')

class ItemHierarchy extends React.Component
  constructor: (props) ->
    super(props)
    this.state = ItemHierarchyStore.getState()

  componentDidMount: =>
    ItemHierarchyStore.listen(this.onChange)
    ItemHierarchyActions.fetchAnalysis(this.props.params.name)

  componentWillUnmount: =>
    ItemHierarchyStore.unlisten(this.onChange)

  onChange: (store) =>
    this.setState(store)

  selectPath: (path) ->
    ItemHierarchyActions.selectPath(path)

  render: ->
    if this.state.isLoading
      return <p>Loading</p> # <Spinner />

    champion = this.state.champion
    starting_items = this.state.analysis.children

    return(
      <MasterTemplate>
        <section className='content centered item-hierarchy'>
          <div className='splash-image__background'>
            <img src="http://ddragon.leagueoflegends.com/cdn/img/champion/splash/#{champion.name}_0.jpg" className='splash-image'/>
          </div>
          <ItemExplorer
            path={[]}
            items={this.state.analysis.children}
            caption='Starting Items'
            onClick={this.selectPath}
            path={this.state.path}
          />
        </section>

      </MasterTemplate>
    )

module.exports = ItemHierarchy
