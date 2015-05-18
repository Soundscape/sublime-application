Core = require 'sublime-core'
http = require 'http'
express = require 'express'
morgan = require 'morgan'
require 'sugar'

class Application extends Core.CoreObject
  constructor: (options) ->
    super(options)
    @app = express()

  use: (fn) -> fn.call @, @app

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