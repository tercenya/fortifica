var ExtractTextPlugin = require("extract-text-webpack-plugin");

module.exports = {
  verbose: false,
  // Use preBootstrapCustomizations to change $brand-primary. Ensure this preBootstrapCustomizations does not
  // depend on other bootstrap variables.
  // preBootstrapCustomizations: path.join(__dirname, './_pre-bootstrap-customizations.scss'),

  // Use bootstrapCustomizations to utilize other sass variables defined in preBootstrapCustomizations or the
  // _variables.scss file. This is useful to set one customization value based on another value.
  // bootstrapCustomizations: path.join(__dirname, './_bootstrap-customizations.scss'),

  // mainSass: "./_main.scss",

  debug: false,
  // Default for the style loading is to put in your js files
  // styleLoader: "style-loader!css-loader!sass-loader",

  // If you want to use the ExtractTextPlugin
  //   and you want compressed
  //     styleLoader: ExtractTextPlugin.extract("style-loader", "css-loader!sass-loader"),
  //   or if you want expanded CSS
  styleLoader: ExtractTextPlugin.extract("style-loader", "css!sass?outputStyle=expanded"),

  // ### Scripts
  // Any scripts here set to false will never
  // make it to the client, it's not packaged
  // by webpack.
  scripts: {
    'transition': false,
    'alert': false,
    'button': false,
    'carousel': false,
    'collapse': false,
    'dropdown': false,
    'modal': true,
    'tooltip': false,
    'popover': false,
    'scrollspy': false,
    'tab': false,
    'affix': false
  },
  // ### Styles
  // Enable or disable certain less components and thus remove
  // the css for them from the build.
  styles: {
    "mixins": true,

    "normalize": true,
    "print": false,

    "scaffolding": true,
    "type": false,
    "code": false,
    "grid": true,
    "tables": false,
    "forms": false,
    "buttons": false,

    "component-animations": false,
    "glyphicons": false,
    "dropdowns": false,
    "button-groups": false,
    "input-groups": false,
    "navs": false,
    "navbar": false,
    "breadcrumbs": false,
    "pagination": false,
    "pager": false,
    "labels": false,
    "badges": false,
    "jumbotron": true,
    "thumbnails": false,
    "alerts": false,
    "progress-bars": false,
    "media": false,
    "list-group": false,
    "panels": false,
    "wells": false,
    "close": false,

    "modals": true,
    "tooltip": false,
    "popovers": false,
    "carousel": false,

    "utilities": false,
    "responsive-utilities": false
  }
};
