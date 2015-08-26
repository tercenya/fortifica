Fortifica = require('./components/ReactRoot')

module.exports = {
  Fortifica: Fortifica
}

# TODO: move this into the webpack config with expose-loader?
window.Fortifica = Fortifica
window.React = require('react')
