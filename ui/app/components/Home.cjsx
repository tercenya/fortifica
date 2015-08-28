React = require('react')
MasterTemplate = require('./MasterTemplate')
ChampionList = require('./ChampionList')

class Home extends React.Component
  render: ->
    return(
      <MasterTemplate>
        <header className='masthead'>
          <div className='masthead-title__container'>
            <p className='masthead-title'>fortifica</p>
            <p className='masthead-subtitle'>Item Build Path Generator for League of Legends</p>
          </div>
          <nav className='master-nav'>
            <a className='master-nav__link'>Champions</a>
            <a className='master-nav__link'>Methodology</a>
            <a className='master-nav__link'>About</a>
         </nav>
        </header>
        <section>
          <ChampionList />
        </section>

      </MasterTemplate>
    )

module.exports = Home
