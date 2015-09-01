React = require('react')
MasterTemplate = require('./MasterTemplate')

class About extends React.Component
  render: ->
    return(
      <MasterTemplate halfPage={false} >
        <section className='content about'>
          <div className='splash-image__background'>
            <img src='https://static2.lolwallpapers.net/2015/01/Victorious-Morgana.jpg' width='1215' height='683' className='splash-image'/>
          </div>
          <div className='text'>
            <h2>About the Author</h2>
            <p>Craig is a fan of many video games and hard challenges, a full time nerds and definitely one of the <a href="https://www.youtube.com/watch?v=8rwsuXHA7RA">crazy ones</a>.  He is a former Senior DevOps Engineer for Apple, and is currently a staff member in the <a href="https://afpc.tamu.edu/">Agricultural and Food Policy Center</a> at <a href="http://ww.tamu.edu">Texas A&amp;M University</a>, a <a href="http://agrilife.org/agrilife-agencies/research-home/">Research and Extension Services</a> unit in the department of <a href="http://agecon.tamu.edu/">Department of Agricultural Economics</a>.</p>
          </div>
        </section>
      </MasterTemplate>
    )

module.exports = About
