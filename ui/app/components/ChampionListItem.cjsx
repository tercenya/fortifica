_ = require('lodash')
React = require('react')
{ Link } = require('react-router')

class ChampionListItem extends React.Component
  render: ->
    champion = this.props.champion
    squareImage = "http://ddragon.leagueoflegends.com/cdn/5.16.1/img/champion/#{champion.id}.png"
    href = "/champions/#{champion.name}"

    <li key=champion.id className='champion-listitem'>
      <Link to='championDetails' params={{name: champion.name}} >
        <div className='champion-listitem__image_background'>
          <img className='champion-listitem__image' src={squareImage} alt={champion.name} />
        </div>
        <div className='champion-listitem__text'>{champion.name}</div>
      </Link>
    </li>

module.exports = ChampionListItem
