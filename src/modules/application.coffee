Core = require 'sublime-core'
http = require 'http'
express = require 'express'
morgan = require 'morgan'
bodyParser = require 'body-parser'
helmet = require 'helmet'
csrf = require 'csurf'
cookieParser = require 'cookie-parser'
compress = require 'compression'
cons = require 'consolidate'
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
  use: (fn) ->
    fn.call @, @app
    @

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
    @

    useDefaults: () ->
      fn = (app) ->
        app.cookieParser = cookieParser()

        app.engine 'html', cons.handlebars
        app.set 'view engine', 'html'
        app.set 'views', './out/views'

        app.use bodyParser.json()
        app.use bodyParser.urlencoded(extended: true)
        app.use app.cookieParser
        app.use compress()

      @use fn

    router: (path, fn) ->
      router = express.Router()

      fn.apply @, router
      @app.use '/api', router
      @

module.exports = Application
