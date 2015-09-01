
headers = {
  'Accept': 'application/json'
  'Content-Type': 'application/json'
}

module.exports = {
  fetchAnalysis: (id) ->
    fetch("./analysis/#{id}.json",
      method: 'get',
      headers: headers
    ).then( (response) ->
      response.text()
    ).then( (text) ->
      JSON.parse(text)
    )
}
