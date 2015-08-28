React = require('react')
Home = require('./Home')

class ReactRoot extends React.Component
  render: ->
    return(
      <Home />
    )

module.exports = ReactRoot
