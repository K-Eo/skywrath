require('dotenv').config()

const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

let PUSHER_KEY = null
const PUSHER_URL = process.env.PUSHER_URL || ""

const pusher_match = PUSHER_URL.match(/http:\/\/([a-f0-9]*)/)

if (pusher_match && pusher_match.length > 0) {
  PUSHER_KEY = pusher_match[1]
} else {
  PUSHER_KEY = ""
}

const DEBUG = process.env.RAILS_ENV === 'development' ? 'skywrath:*' : ''

environment.plugins.set(
  'Pusher',
  new webpack.DefinePlugin({
    'process.env': {
      PUSHER_KEY: JSON.stringify(PUSHER_KEY),
      DEBUG: JSON.stringify(DEBUG)
    }
  })
)

module.exports = environment
