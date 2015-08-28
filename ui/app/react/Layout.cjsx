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
      <MasterTemplate>
        <RouteHandler {...this.props} />
      </MasterTemplate>
    )

module.exports = Layout
