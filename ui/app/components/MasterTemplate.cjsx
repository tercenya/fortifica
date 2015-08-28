React = require('react')

class MasterTemplate extends React.Component
  render: ->
    return(
      <div className='master-layout__container'>
        <div className='master-layout'>
          {this.props.children}
        </div>
      </div>
    )

module.exports = MasterTemplate
