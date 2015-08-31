# Fortifica
An item build path and item-set generator for League of Legends


## Tour of the Code

The project is divided into three components, the _ui_, the _analyzer_, and the _dataminer_.

## ui

##### Purpose

The UI is a [one-way databound](https://facebook.github.io/react/docs/thinking-in-react.html) [single page](https://github.com/rackt/react-router) [react](https://facebook.github.io/react/)/[flux](https://facebook.github.io/flux/docs/overview.html) application.  

The flux implementation is handled via [goatslacker/alt](https://github.com/goatslacker/alt), which vastly reduces the boilerplate.  Routing is handled via [rackt/react-router](rackt/react-router).  Curly braces are eschewed in favor of [coffeescript](http://coffeescript.org/).  React components are full [ES6 classes](https://facebook.github.io/react/docs/reusable-components.html#es6-classes) with [JSX transformation](https://facebook.github.io/react/docs/jsx-in-depth.html). Asset pipelining and compilation is handled via [webpack](https://webpack.github.io/).


##### Requirements

- nodejs v0.12.X
- [npm](https://www.npmjs.com/)
- compilation tools (Xcode and command-line tools)

To install and run,

```
  cd ui
  npm install
  npm run hot
```

You should be able to view the website at http://localhost:5001/app.  The hot-reload version will refresh with source-code changes to facilitate development.  You may want to replace the `ui/analysis` folder with output from your own analysis runs.

To build a production version of the website, run `npm run build`.  The `ui/output` folder will have a self-contained version of the website, which is checked into the [gh-pages branch](https://github.com/tercenya/fortifica/tree/gh-pages) on github.

#### WARNINGS

Don't use the (soon-to-be) deprecated React mixins or `React.createClass`.

Don't `require('analysis/Champion.json')` - you severely bloat the application, assuming you don't OOM the transpiler.

## analyzer

##### Purpose

The analyzer takes match data provided by the dataminer and builds node-trees of used item paths.  It will comb any `.json` files located in `analyzer/data` as source material.  A convenient solution is to provide one or two sample games for testing.  You can also symlink a datamined match folder to perform a bulk run.  The output it placed in analyzer/output, and are also static data files.  No database is required for this application.

WARNING: the analyzer is memory intensive.  a typical run of 5000 games usually requires at least 4GB of RAM, and running the full 5.14 provided match dataset may exceed 8GB.  Expect to run an hour per 10,000 records.

##### Requirements

- ruby 2.X
- [bundler](http://bundler.io/)

To install and run,

```
  mkdir analyzer/data
  # copy some match json files into analyzer/data

  cd analyzer
  bundler install
  ./run.rb
```

## dataminer

##### Purpose

Downloads bulk match data.  Unlike the API 1.0 competition, Riot provided [data set indexes](https://developer.riotgames.com/discussion/announcements/show/2lxEyIcE); this dataminer has been stripped down to efficiently download the massive datasets via the [match-v2.2 endpoint](https://developer.riotgames.com/api/methods#!/1027/3483).

##### Requirements

- ruby 2.X
- [bundler](http://bundler.io/)

##### Setup

Add your riot API key to `config/api.key`.  A sample configuration file is provided.

#### WARNINGS

The `config/api.key` file is intentionally excluded from source control.  Do not check in your api key.

The dataminer can easily exceed developer key [rate limits](https://developer.riotgames.com/docs/api-keys), and can get you [blacklisted](https://developer.riotgames.com/docs/rate-limiting).  You will need at least a temporary production key to run this code.  Various `sleep` statements have been removed from `lib/riot/api.rb`, which can be reimplemented if throttling is required.  See [invalesco](https://github.com/tercenya/invalesco/tree/dataminer) for a more conservative/well-behaved dataminer.


To install and run,

```ruby
  cd dataminer
  bundler install
  ./bin/parallel.rb
```

##### Notes

The dataminer is not general-purpose, and requires configuration of inputs in `bin/parallel.rb` and outputs in `lib/riot/api.rb`.


# Disclaimer

Fortifica isn't endorsed by Riot Games and doesn't reflect the views or opinions of Riot Games or anyone officially involved in producing or managing League of Legends. League of Legends and Riot Games are trademarks or registered trademarks of Riot Games, Inc. League of Legends © Riot Games, Inc.

# License

Fortifica - Item Set Evolution for League of Legends
Copyright (C) 2015 Craig M. Wellington

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
