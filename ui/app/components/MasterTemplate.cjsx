React = require('react')
$ = require('jquery')
{ Link } = require('react-router')

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
              <Link className='masthead-title' id='title' to='home'>fortifica</Link>
              <div className='masthead-subtitle'>Item Build Path Generator for League of Legends</div>
            </div>
            <nav className='master-nav'>
              <Link className='master-nav__link' to='champions' onClick={this.scrollToChampions}>Champions</Link>
              <Link className='master-nav__link' to='faq'>How To - FAQ</Link>
              <Link className='master-nav__link' to='about'>About</Link>
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
