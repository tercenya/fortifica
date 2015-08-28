ReactRouter = require('react-router')
routes = require('./routes')

router = ReactRouter.create
  location: ReactRouter.HashLocation
  routes: routes

module.exports = router
