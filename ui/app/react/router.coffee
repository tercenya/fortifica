ReactRouter = require('react-router')
routes = require('./routes')

router = ReactRouter.create
  location: ReactRouter.HistoryLocation
  routes: routes

module.exports = router
