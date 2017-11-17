const environment = require('./environment')
const webpack = require('webpack')

environment.plugins.set(
  'Define',
  new webpack.DefinePlugin({
    'process.env': {
      DEBUG: JSON.stringify("*")
    }
  })
)

module.exports = environment.toWebpackConfig()
