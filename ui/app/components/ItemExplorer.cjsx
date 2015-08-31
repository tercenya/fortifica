_ = require('lodash')
React = require('react')
Item = require('./Item')

class ItemExplorer extends React.Component
  render: ->
    items = _.map this.props.items, (e) ->
      <div className='item-explorer__item' key={e.item_id}>
        <Item itemId={e.item_id} />
        <span>{e.count} times</span>
      </div>

    return(
      <div className='item-explorer'>
        <span>{this.props.caption}</span>
        {items}
      </div>
    )

module.exports = ItemExplorer
