_ = require('lodash')
React = require('react')
numbro = require('numbro')
DownloadButton = require('downloadbutton')

Item = require('./Item')
DDragon = require('../utils/DataDragonAPI')
ItemSetGenerator = require('../utils/ItemSetGenerator')



class InventoryElement extends React.Component
  @defaultProps = {
    path: []
  }

  onClick: =>
    if this.props.onClick
      console.log(this.props.path)
      path = _.dropRight(this.props.path)
      this.props.onClick(path)

  render: ->
    itemId = this.props.itemId
    analysis = this.props.analysis

    item = DDragon.lookupItem(itemId)

    <div className='item-explorer__inventory' onClick={this.onClick}>
      <Item itemId={itemId} />
    </div>

class ItemExplorerElement extends React.Component
  @defaultProps = {
    path: []
  }

  onClick: =>
    if this.props.onClick
      # path = [].concat(this.props.path, [this.props.itemId])
      path = this.props.path || []
      path.push(this.props.itemId)
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
  generateItemSet: =>
    {
      mime: 'text/json'
      filename: "foritifica-#{Date.now()}.json"
      contents: ItemSetGenerator.build(this.props.path, this.props.champion)
    }

  render: ->
    path = this.props.path
    onClick = this.props.onClick

    leaf = this.props.items

    inventory = _.map path, (item_id,i) ->
      console.log("inventory: #{item_id}")
      item = _.find leaf, (e) -> e.item_id == item_id
      leaf = item.children

      <InventoryElement
        itemId={item_id}
        key={i}
        path={path.slice(0,i+1)}
        onClick={onClick}
      />

    downloadButton = if inventory
      <DownloadButton
        className='btn download-button'
        genFile={this.generateItemSet}
        downloadTitle='Download Item Set'
      />


    console.log(leaf)
    items = if leaf
      total = _.sum leaf, (e) -> e.count


      # sort by most popular
      options = _.sortBy leaf, (e) -> e.count
      options.reverse()

      _.map options, (analysis,i) ->
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
        <div className='download-button__container'>{downloadButton}</div>
        Build Path:
        {inventory}
        <hr />
        {items}
      </div>
    )




module.exports = ItemExplorer
