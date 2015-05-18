Core = require 'sublime-core'
cluster = require 'cluster'
numCPUs = require('os').cpus().length
domain = require 'domain'
require 'sugar'

class Cluster extends Core.CoreObject
  constructor: (fn, options) ->
    super(options)

    if cluster.isMaster
      for i in [0..numCPUs]
        cluster.fork()

      cluster.on 'exit', (worker) ->
        cluster.fork()

    else
      d = domain.create()

      d.on 'error', (err) ->
        process.exit 1

      console.log 'fn'
      d.run fn

module.exports = Cluster
