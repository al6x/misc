exports.route = (routes, path, data, res) ->
  if routes[path]    
    routes[path](data, res)
  else
    console.log "no handler for #{path}!"