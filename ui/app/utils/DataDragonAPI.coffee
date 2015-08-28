headers = {
  'Accept': 'application/json'
  'Content-Type': 'application/json'
}

# we can't use ddragon directly due to CORS, but we can simulate the responses
module.exports = {
  fetchChampions: ->
    return new Promise (resolve, reject) -> resolve(require('../../ddragon/champion.json'))

  # this fails due to CORS
  fetchChampionsLive: ->
    fetch("http://ddragon.leagueoflegends.com/cdn/5.16.1/data/en_US/champion.json",
      method: 'get',
      headers: headers
    ).then( (response) ->
      response.text()
    ).then( (text) ->
      JSON.parse(text)
    )
}
