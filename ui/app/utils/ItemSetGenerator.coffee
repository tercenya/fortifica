_ = require('lodash')

module.exports =
  build: (path, champion) ->
    blocks = _.each path, (item_id, i) ->
      {
        "type": "#{i}"
        "recMath": false
        "items": [
          {
            "id": "#{item_id}"
            "count": 1
          }
        ]
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
