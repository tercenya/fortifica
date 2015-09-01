_ = require('lodash')

module.exports =
  build: (path, champion) ->
    items = _.map path, (item_id, i) ->
      {
        "id": "#{item_id}"
        "count": 1
      }

    blocks =
      {
        "type": "0"
        "recMath": false
        "items": items
      }

    data = {
      "title": "#{champion.name} - Fortifica"
      "type": "custom"
      "map": "any"
      "mode": "any"
      "priority": false
      "sortrank": 0
      "blocks": blocks
    }

    return JSON.stringify(data)
