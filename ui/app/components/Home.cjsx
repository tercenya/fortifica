React = require('react')
MasterTemplate = require('./MasterTemplate')
ChampionList = require('./ChampionList')

class Home extends React.Component
  render: ->
    return(
      <MasterTemplate halfPage={true} >
        <section className='content'>
          <ChampionList />
        </section>
      </MasterTemplate>
    )

module.exports = Home
