_ = require('lodash')
React = require('react')

class Champion extends React.Component
  render: ->
    champion = this.props.champion
    squareImage = "http://ddragon.leagueoflegends.com/cdn/5.16.1/img/champion/#{champion.id}.png"
    <li key=champion.id className='champion-listitem'>
      <img className='champion-listitem__image' src={squareImage} alt={champion.name} />
      <div className='champion-listitem__text'>{champion.name}</div>
    </li>

module.exports = Champion
