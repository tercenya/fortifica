_ = require('lodash')
React = require('react')
Item = require('./Item')
DDragon = require('../utils/DataDragonAPI')
numbro = require('numbro')

class ItemExplorer extends React.Component
  render: ->

    total = _.sum this.props.items, (e) -> e.count

    items = _.map this.props.items, (e) ->
      percent = numbro(e.count / total).format('0.0%')
      item = DDragon.lookupItem(e.item_id)
      <div className='item-explorer__item' key={e.item_id}>
        <Item itemId={e.item_id} />
        <p className='item-explorer__item-name'>
          {item.name}
          <br/>
          {e.count} ({percent})
        </p>
      </div>

    return(
      <div className='item-explorer'>
        <span>{this.props.caption}</span>
        {items}
      </div>
    )

module.exports = ItemExplorer
