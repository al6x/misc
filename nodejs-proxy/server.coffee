exports.start = (route, routes) ->
  http = require 'http'
  url = require 'url'
  querystring = require 'querystring'
  
  http.createServer((req, res) ->
    path = url.parse(req.url).pathname
    console.log "processing #{path}"
        
    route routes, path, req, res
  ).listen 3000
  console.log "Server started"