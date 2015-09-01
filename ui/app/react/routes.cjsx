React = require('react')
{ Route, DefaultRoute } = require('react-router')

Layout = require('./Layout')
Home = require('../components/Home')
Champions = require('../components/Champions')
ItemHierarchy = require('../components/ItemHierarchy')
Methodology = require('../components/Methodology')

routes = (
    <Route name='root' path='/' handler={Layout}>
      <DefaultRoute name='home' handler={Home} />
      <Route path='/champions' name='champions' handler={Champions} />
      <Route path='/champions/:name' name='championDetails' handler={ItemHierarchy} />
      <Route path='/faq' name='faq' handler={Methodology} />
    </Route>
)

module.exports = routes
