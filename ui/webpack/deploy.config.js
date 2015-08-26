module.exports = require("./webpack.config")({
  devServer: false,
  hotComponents: false,
  devtool: "eval",
  debug: false,
  separateStylesheet: true
});
