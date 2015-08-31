_ = require('lodash')
React = require('react')
Item = require('./Item')
DDragon = require('../utils/DataDragonAPI')
numbro = require('numbro')

class ItemExplorerElement extends React.Component
  @defaultProps = {
    path: []
  }

  onClick: =>
    if this.props.onClick
      path = this.props.path.concat([this.props.itemId])
      this.props.onClick(path)

  render: ->
    itemId = this.props.itemId
    analysis = this.props.analysis

    item = DDragon.lookupItem(itemId)
    counts = if this.props.total
      percent = numbro(analysis.count / this.props.total).format('0.0%')
      <span>{analysis.count} ({percent})</span>
    else
      <span></span>


    <div className='item-explorer__item' onClick={this.onClick}>
      <Item itemId={itemId} />
      <p className='item-explorer__item-name'>
        {item.name}
        <br/>
        {counts}
      </p>
    </div>

class ItemExplorer extends React.Component
  render: ->
    path = this.props.path
    console.log("path is")
    console.log(path)

    leaf = this.props.items

    inventory = _.map path, (item_id,i) ->
      console.log("inventory: #{item_id}")
      item = _.find leaf, (e) -> e.item_id == item_id
      leaf = item.children

      <ItemExplorerElement
        itemId={item_id}
        analysis={item}
        key={i}
        path={path.slice(i)}
      />

    console.log(leaf)
    items = if leaf
      total = _.sum leaf, (e) -> e.count
      onClick = this.props.onClick

      _.map leaf, (analysis,i) ->
        <ItemExplorerElement
          itemId={analysis.item_id}
          analysis={analysis}
          total={total}
          key={i}
          path={path}
          onClick={onClick}
        />
    else
      <p>No additional data.</p>


    return(
      <div className='item-explorer'>
        {inventory}
        <hr />
        {items}
      </div>
    )




module.exports = ItemExplorer
