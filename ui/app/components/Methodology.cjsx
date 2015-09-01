React = require('react')
MasterTemplate = require('./MasterTemplate')

class Methodology extends React.Component
  render: ->
    return(
      <MasterTemplate halfPage={false} >
        <section className='content methodology'>
          <div className='splash-image__background'>
            <img src='http://i.imgur.com/HRgupVM.jpg' width='1215' height='1018' className='splash-image'/>
          </div>
          <div className='text'>

            <h2>Methodology</h2>
            <p>

            </p>

            <hr />


            <h2>How to build an Item Set</h2>
            <p>
              Choose a champion, then select items.  When you have the build out you want, click <i>Download Item Set</i> to download the item set. You can drop these in your League of Legends folder to use them as item sets in the game. See the <a href='https://developer.riotgames.com/docs/item-sets'>Item Sets Documentation</a> from Riot for information on how to use these files with your computer.
            </p>
            <p>You will likely want to clean up or organize the build path once in the client to better organize your purchases.</p>

            <hr />

            <h3>Limitations</h3>
            <p>The analysis currently only contains the patch 5.14 North American item builds.  Analysis data will be updated as it becomes avaialble.</p>

            <hr />

            <h3>Why do I see mutiples of some items deep in the build path?</h3>
            <p>It could be that the player sold and re-bought the item (which is usually a sub-optimtal use of gold).  Also, the analyser cannot currently handle the ITEM_UNDO event, which may cause spurious paths.</p>

            <hr />

            <h3>
              Why can I not build Sightstone/(insert item here) outright?
              <br/>
              Why do I need a Ruby Crystal/(various prereqs) first?
            </h3>
            <p>Buying an item automatically buys any prerequsite components that you are missing in your inventory.  Even if the timeline data shows a player bought an item outright, we treat it for the purpose of the build path as if they had bought the components in order.  You can remove the intermediates after you have created the item set if you want to consolidate your purchase decision in the client.</p>

            <hr />

            <h3>I always start Hunters Machete on <a href='/fortifica/#/champions/Sona'>Sona</a>!  Why is not in the starting items?</h3>
            <p>There were no jungle-Sonas in the analysis data set.  Although I am personally in testing the limits of your favorite champion, or trying an unusual build, you are not likely to find that information within the 'wisdom the crowds.'
            </p>

          </div>


        </section>
      </MasterTemplate>
    )

module.exports = Methodology
