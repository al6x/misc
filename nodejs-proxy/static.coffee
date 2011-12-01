static = require 'node-static'

file = new(static.Server)('./files');

require('http').createServer((request, response) ->
  request.addListener 'end', () ->
    file.serve request, response
).listen(3000);