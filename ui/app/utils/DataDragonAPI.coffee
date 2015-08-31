headers = {
  'Accept': 'application/json'
  'Content-Type': 'application/json'
}

# we can't use ddragon directly due to CORS, but we can simulate the responses
module.exports = {
  fetchChampions: ->
    return new Promise (resolve, reject) -> resolve(require('../../ddragon/champion.json'))

  fetchChampion: (name) ->
    return new Promise (resolve, reject) ->
      champions = require('../../ddragon/champion.json')
      resolve(champions.data[name])

  fetchChampionsLive: ->
    fetch("http://ddragon.leagueoflegends.com/cdn/5.16.1/data/en_US/champion.json",
      method: 'get',
      headers: headers
    ).then( (response) ->
      response.text()
    ).then( (text) ->
      JSON.parse(text)
    )

  lookupItem: (id) ->
    items = require('../../ddragon/item.json')
    return items.data[id]
}
