React = require('react')
{ Route, DefaultRoute } = require('react-router')

Layout = require('./Layout')
Home = require('../components/Home')
ItemHierarchy = require('../components/ItemHierarchy')

routes = (
    <Route name='root' path='/fortifica/' handler={Layout}>
      <DefaultRoute name='home' handler={Home} />
      <Route path='/fortifica/champion/:name' name='championDetails' handler={ItemHierarchy} />
    </Route>
)

module.exports = routes
