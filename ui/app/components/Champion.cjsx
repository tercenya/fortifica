_ = require('lodash')
React = require('react')

class Champion extends React.Component
  render: ->
    champion = this.props.champion
    squareImage = "http://ddragon.leagueoflegends.com/cdn/5.16.1/img/champion/#{champion.id}.png"
    href = "/champions/#{champion.name}"

    <li key=champion.id className='champion-listitem'>
      <a href={href}>
        <div className='champion-listitem__image_background'>
          <img className='champion-listitem__image' src={squareImage} alt={champion.name} />
        </div>
        <div className='champion-listitem__text'>{champion.name}</div>
      </a>
    </li>

module.exports = Champion
