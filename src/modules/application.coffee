Core = require 'sublime-core'
http = require 'http'
express = require 'express'
morgan = require 'morgan'
require 'sugar'

# Provides a simple express application
class Application extends Core.CoreObject
  # Construct a new Application
  #
  # @param [Object] options Configuration options to be associated with the instance
  constructor: (options = {}) ->
    super(options)
    @app = express()

  # Wraps the express use function
  #
  # @param [Function] fn The function used to configure the application
  use: (fn) -> fn.call @, @app

  # Start the application
  #
  # @param [Integer] port The port on which to serve the application
  start: (port) ->
    port = if port then port
    else (process.env.PORT || @options.port)

    @app.set 'port', port

    if process.env['NODE_ENV'] != 'production'
      @app.use morgan 'dev',
        immediate: true
        format: 'dev'

    if @options.ssl
      fs = require 'fs'
      https = require 'https'
      httpsOptions =
        key: fs.readFileSync @options.key
        cert: fs.readFileSync @options.cert

      @httpServer = https.createServer(httpsOptions, @app).listen port
    else
      @httpServer = http.createServer(@app).listen port

module.exports = Application
