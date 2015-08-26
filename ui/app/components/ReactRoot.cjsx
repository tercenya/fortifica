React = require('react')

class ReactRoot extends React.Component
  render: ->
    return(
      <div>
        <h2>Fortifica</h2>
        <h4>
          <a
            href='https://developer.riotgames.com/discussion/announcements/show/2lxEyIcE'
            target='_blank'
          >
            Riot Game API Challenge 2.0
          </a>
        </h4>
        <p>Placeholder</p>
      </div>
    )

module.exports = ReactRoot

