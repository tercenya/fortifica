React = require('react')
$ = require('jquery')

class MasterTemplate extends React.Component
  @defaultProps = {
    halfPage: false
  }

  scrollToChampions: ->
    $('html, body').animate({
      scrollTop: $("#title").offset().top
    }, 500);

  render: ->
    klass = if this.props.halfPage then 'halfpage' else 'topbar'
    return(
      <div className='master-layout__container'>
        <div className="master-layout #{klass}">
          <header className='masthead'>
            <div className='masthead-title__container'>
              <p className='masthead-title' id='title'>fortifica</p>
              <p className='masthead-subtitle'>Item Build Path Generator for League of Legends</p>
            </div>
            <nav className='master-nav'>
              <a className='master-nav__link' href='#' onClick={this.scrollToChampions}>Champions</a>
              <a className='master-nav__link' href='#/methodology'>Methodology</a>
              <a className='master-nav__link' href='#/about'>About</a>
           </nav>
          </header>

          {this.props.children}

          <footer className='master-footer'>
            <div className='left'>
              &copy; 2015 Tercenya
            </div>
            <div className='right'>
              <a href='http://github.com/tercenya/fortifica/' target='_blank'>
                source code
              </a>
            </div>
          </footer>
        </div>
      </div>
    )

module.exports = MasterTemplate
