Home = require('./Home')
$ = require('jquery')

class Champions extends Home
  componentDidMount: ->
    $('html, body').animate({
      scrollTop: $("#title").offset().top
    }, 100);

module.exports = Champions
