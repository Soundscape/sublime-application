Core = require 'sublime-core'
lib = require '../'
bodyParser = require 'body-parser'
helmet = require 'helmet'
csrf = require 'csurf'
express = require 'express'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'
compress = require 'compression'
cons = require 'consolidate'
config = require 'config'

describe 'Application test suite', ()  ->
  instance = new lib.Application config.server

  it 'should construct an instance', () ->
    expect(instance).not.toBeNull()

  it 'should extend an instance', () ->
    expect(instance).not.toBeNull()

    instance.use (app) ->
      app.use bodyParser.json()

      app.use helmet.xframe()
      app.use helmet.hsts()

  it 'should register routes', () ->
    expect(instance).not.toBeNull()

    instance.use (app) ->
      app.get '/heartbeat', (req, res) ->
        res
        .status 200
        .json 'OK'
  ###
  it 'should register ui routes', () ->
    expect(instance).not.toBeNull()

    instance.use (app) ->
      app.cookieParser = cookieParser config.server.secret

      app.engine 'html', cons.handlebars
      app.set 'view engine', 'html'
      app.set 'views', 'views'

      app.use bodyParser.json()
      app.use bodyParser.urlencoded()
      app.use app.cookieParser
      app.use compress()

      app.use express.static(
        '../public',
        maxAge: config.server.staticCache
      )

      app.get '/', (req, res) ->
        model =
          title: 'Sublime test page'

        res.render 'index', model
  ###

  it 'should start an instance', () ->
    expect(instance).not.toBeNull()
    instance.start()
