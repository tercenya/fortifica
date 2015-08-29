React = require('react')
{ RouteHandler, Link } = require('react-router')
{ PropTypes } = React

MasterTemplate = require('../components/MasterTemplate')

class Layout extends React.Component
  @propTypes =
    params: PropTypes.object.isRequired
    query: PropTypes.object.isRequired

  render: ->
    return(
      <RouteHandler {...this.props} />
    )

module.exports = Layout
