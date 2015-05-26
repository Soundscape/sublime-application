Core = require 'sublime-core'
cluster = require 'cluster'
numCPUs = require('os').cpus().length
domain = require 'domain'
require 'sugar'

# Provides clustering functionality
class Cluster extends Core.CoreObject
  # Construct a new Cluster
  #
  # @param [Function] fn The function to run in each CPU
  # @param [Object] options Configuration options to be associated with the instance
  constructor: (fn, options = {}) ->
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
