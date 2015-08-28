React = require('react')
router = require('./react/router')
$ = require('jquery')

$ ->
  router.run( (Handler, state) ->
    React.render(<Handler {...state} />, document.body)
  )
