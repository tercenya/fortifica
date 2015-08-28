path = require('path')
webpack = require('webpack')
_ = require('lodash')
ExtractTextPlugin = require('extract-text-webpack-plugin')
StatsPlugin = require('stats-webpack-plugin')
loadersByExtension = require('./util/loadersByExtension')

module.exports = (options) ->
  root = path.join(__dirname, '../')
  base = path.join(root, 'app')

  entry =
    material: [
      path.join(root, '/config/mdl/config.coffee')
      path.join(root, '/config/mdl/style.scss')
    ]
    bootstrap: [
      'bootstrap-sass!' + path.join(root, '/config/bootstrap/config.js')
    ]
    fortifica: [
      path.join(base, 'app.cjsx')
      path.join(base, 'fortifica.scss')
    ]
    index: '!file-loader?name=../index.html!' + path.join(base, 'index.html')

  hotLoader = []
  hotLoader.push 'react-hot-loader' if options.devServer
  hotLoader.push 'babel-loader?stage=0'

  loaders =
    'jsx':
      loader: hotLoader
      include: base

    'jsx|js':
      loader: 'babel-loader?stage=0'
      exclude: [
        base
        path.join(root, 'node_modules')
      ]

    'coffee': 'coffee-loader'
    'cjsx': [ 'coffee-loader', 'cjsx-loader' ]

    'txt': 'raw-loader'
    'png|jpg|jpeg|gif|svg': 'url-loader?limit=1000'
    'woff|woff2': 'url-loader?limit=100000&minetype=application/font-woff'
    'ttf|eot': 'file-loader'
    'wav|mp3': 'file-loader'
    'svg': 'file-loader'
    'html': 'html-loader'
    'md|markdown': [ 'html-loader', 'markdown-loader' ]
    'json': 'json-loader'

  cssLoader = 'css-loader'
  stylesheetLoaders =
    'css': cssLoader
    'less': [ cssLoader, 'less-loader' ]
    'scss|sass': [ cssLoader, 'sass-loader' ]

  additionalLoaders = [
    {
      test: /bootstrap/
      loader: 'imports?jQuery=jquery'
    }
    {
      test: require.resolve('material-design-lite/material')
      loader: 'exports?componentHandler'
    }
  ]

  alias =
    fortifica: base
    lacuna: path.join(root, 'lacuna/index')


  aliasLoader = {}
  externals = []

  modulesDirectories = [
    'web_modules'
    'node_modules'
  ]

  extensions = [
    ''
    '.js'
    '.jsx'
    '.coffee'
    '.cjsx'
    '.scss'
  ]

  publicPath = if options.devServer then 'http://localhost:5001/assets/' else '/assets'

  output =
    path: path.join(root, 'build', 'assets')
    publicPath: publicPath
    filename: '[name].js'
    chunkFilename: (if options.devServer then '[id].js' else '[name].js')
    sourceMapFilename: 'debugging/[file].map'
    libraryTarget: undefined
    pathinfo: options.debug

  excludeFromStats = [
    /node_modules[\\\/]react(-router)?[\\\/]/
    /node_modules[\\\/]items-store[\\\/]/
  ]

  plugins = [
    new (webpack.PrefetchPlugin)('react')
    new (webpack.PrefetchPlugin)('react/lib/ReactComponentBrowserEnvironment')
    new (webpack.ProvidePlugin)(
      $: 'jquery'
      _: 'lodash'
      'React': 'react'
    )
    new StatsPlugin(path.join(__dirname, 'build', 'stats.json'),
      chunkModules: true
      exclude: excludeFromStats
    )
    new ExtractTextPlugin('[name].css')
  ]

  Object.keys(stylesheetLoaders).forEach (ext) ->
    stylesheetLoader = stylesheetLoaders[ext]
    if Array.isArray(stylesheetLoader)
      stylesheetLoader = stylesheetLoader.join('!')
    stylesheetLoaders[ext] = ExtractTextPlugin.extract('style-loader', stylesheetLoader)
    return

  return {
    entry: entry
    output: output
    target: 'web'
    module:
      loaders: _([]).concat(
        additionalLoaders
        loadersByExtension(loaders)
        loadersByExtension(stylesheetLoaders)
      )
    devtool: options.devtool
    debug: options.debug
    resolveLoader:
      root: path.join(__dirname, 'node_modules')
      alias: aliasLoader
    externals: externals
    resolve:
      root: root
      modulesDirectories: modulesDirectories
      extensions: extensions
      alias: alias
    plugins: plugins
    devServer:
      stats:
        cached: false
        exclude: excludeFromStats
    node:
      fs: "empty"
  }
