_ = require('lodash')
React = require('react')

class Item extends React.Component
  render: ->
    id = this.props.itemId

    return(
      <img src="http://ddragon.leagueoflegends.com/cdn/5.16.1/img/item/#{id}.png" />
    )

module.exports = Item
