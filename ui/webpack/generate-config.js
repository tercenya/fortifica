var path = require('path')
var webpack = require('webpack')
var ExtractTextPlugin = require('extract-text-webpack-plugin')
var StatsPlugin = require('stats-webpack-plugin')
const loadersByExtension = require('./generator/loadersByExtension.js')

module.exports = function(options) {
  var root = path.join(__dirname, 'app')
  var base = path.join(__dirname, '../')

  var entry = {
    material: [
      path.join(base, '/config/mdl/config.coffee'),
      path.join(base, '/config/mdl/style.scss')
    ],
    bootstrap: [
      'bootstrap-sass!' + path.join(base, '/core/config/bootstrap/config.js'),
      'font-awesome-webpack!' + path.join(base, '/core/config/font-awesome.js')
    ],
    foritica: path.join(root, 'foritica.scss')
  }

  var loaders = {
    'jsx': {
      loader: options.hotComponents ? ['react-hot-loader', 'babel-loader?stage=0'] : 'babel-loader?stage=0',
      include: root
    },
    'jsx|js': {
      loader: 'babel-loader?stage=0',
      exclude: [
        root,
        path.join(base, 'node_modules')
      ]
    },
    'json': 'json-loader',
    'coffee': 'coffee-loader',
    'cjsx6': ['babel-loader?stage=0', 'coffee-loader', 'cjsx-loader'],
    'cjsx': ['coffee-loader', 'cjsx-loader'],
    'txt': 'raw-loader',
    'png|jpg|jpeg|gif|svg': 'url-loader?limit=1000',
    'woff|woff2': 'url-loader?limit=100000&minetype=application/font-woff',
    'ttf|eot': 'file-loader',
    'wav|mp3': 'file-loader',
    'svg': 'file-loader',
    'html': 'html-loader',
    'md|markdown': ['html-loader', 'markdown-loader'],
    'jade': 'react-jade-loader'
  }

  // var cssLoader = options.minimize ? 'css-loader?module' : 'css-loader?module&localIdentName=[path][name]---[local]---[hash:base64:5]'
  var cssLoader = 'css-loader'
  var stylesheetLoaders = {
    'css': cssLoader,
    'less': [cssLoader, 'less-loader'],
    'styl': [cssLoader, 'stylus-loader'],
    'scss|sass': [cssLoader, 'sass-loader']
  }
  var additionalLoaders = [
    // { test: /some-reg-exp$/, loader: 'any-loader' }
    { test: /bootstrap/, loader: 'imports?jQuery=jquery' },
  ]
  var alias = {
    fortifica: root,
    lacuna: path.join(base, 'lacuna/index')
  }

  var aliasLoader = {
  }

  var externals = [
  ]

  var modulesDirectories = ['web_modules', 'node_modules']
  var extensions = ['', '.js', '.jsx', '.coffee', '.cjsx', '.scss']

  var publicPath = options.devServer ? 'http://localhost:5000/assets/' : '/assets/'
  var output = {
    path: path.join(__dirname, 'build', options.prerender ? 'prerender' : 'public'),
    publicPath: publicPath,
    filename: '[name].js' + (options.longTermCaching && !options.prerender ? '?[chunkhash]' : ''),
    chunkFilename: (options.devServer ? '[id].js' : '[name].js') + (options.longTermCaching && !options.prerender ? '?[chunkhash]' : ''),
    sourceMapFilename: 'debugging/[file].map',
    libraryTarget: options.prerender ? 'commonjs2' : undefined,
    pathinfo: options.debug || options.prerender
  }
  var excludeFromStats = [
    /node_modules[\\\/]react(-router)?[\\\/]/,
    /node_modules[\\\/]items-store[\\\/]/
  ]
  var plugins = [
    new webpack.PrefetchPlugin('react'),
    new webpack.PrefetchPlugin('react/lib/ReactComponentBrowserEnvironment'),
    new webpack.ProvidePlugin({$: 'jquery', _: 'lodash', 'React': 'react'})
  ]
  if(options.prerender) {
    plugins.push(new StatsPlugin(path.join(__dirname, 'build', 'stats.prerender.json'), {
      chunkModules: true,
      exclude: excludeFromStats
    }))
    aliasLoader['react-proxy$'] = 'react-proxy/unavailable'
    aliasLoader['react-proxy-loader$'] = 'react-proxy-loader/unavailable'
    externals.push(
      /^react(\/.*)?$/,
      /^reflux(\/.*)?$/,
      'superagent',
      'async'
    )
    // plugins.push(new webpack.optimize.LimitChunkCountPlugin({ maxChunks: 1 }))
  } else {
    plugins.push(new StatsPlugin(path.join(__dirname, 'build', 'stats.json'), {
      chunkModules: true,
      exclude: excludeFromStats
    }))
  }
  if(options.commonsChunk) {
    plugins.push(new webpack.optimize.CommonsChunkPlugin('commons', 'commons.js' + (options.longTermCaching && !options.prerender ? '?[chunkhash]' : '')))
  }

  var asyncLoader = {
    // test: require('./app/route-handlers/async').map(function(name) {
    //   return path.join(__dirname, 'app', 'route-handlers', name)
    // }),
    // loader: options.prerender ? 'react-proxy-loader/unavailable' : 'react-proxy-loader'
  }


  Object.keys(stylesheetLoaders).forEach(function(ext) {
    var stylesheetLoader = stylesheetLoaders[ext]
    if(Array.isArray(stylesheetLoader)) {
      stylesheetLoader = stylesheetLoader.join('!')
    }
    if(options.prerender) {
      stylesheetLoaders[ext] = stylesheetLoader.replace(/^css-loader/, 'css-loader/locals')
    } else if(options.separateStylesheet) {
      stylesheetLoaders[ext] = ExtractTextPlugin.extract('style-loader', stylesheetLoader)
    } else {
      stylesheetLoaders[ext] = 'style-loader!' + stylesheetLoader
    }
  })
  if(options.separateStylesheet && !options.prerender) {
    plugins.push(new ExtractTextPlugin('[name].css' + (options.longTermCaching ? '?[contenthash]' : '')))
  }
  if(options.minimize && !options.prerender) {
    plugins.push(
      new webpack.optimize.UglifyJsPlugin({
        compressor: {
          warnings: false
        }
      }),
      new webpack.optimize.DedupePlugin()
    )
  }
  if(options.minimize) {
    plugins.push(
      new webpack.DefinePlugin({
        'process.env': {
          NODE_ENV: JSON.stringify('production')
        }
      }),
      new webpack.NoErrorsPlugin()
    )
  }

  return {
    entry: entry,
    output: output,
    target: options.prerender ? 'node' : 'web',
    module: {
      // loaders: [asyncLoader].concat(additionalLoaders).concat(loadersByExtension(loaders)).concat(loadersByExtension(stylesheetLoaders))
      loaders: additionalLoaders.concat(loadersByExtension(loaders)).concat(loadersByExtension(stylesheetLoaders))
    },
    devtool: options.devtool,
    debug: options.debug,
    resolveLoader: {
      root: path.join(__dirname, 'node_modules'),
      alias: aliasLoader
    },
    externals: externals,
    resolve: {
      root: root,
      modulesDirectories: modulesDirectories,
      extensions: extensions,
      alias: alias
    },
    plugins: plugins,
    devServer: {
      stats: {
        cached: false,
        exclude: excludeFromStats
      }
    }
  }
}
