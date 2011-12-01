http = require 'http'
url = require 'url'
fs = require 'fs'
# mime = require 'mime'

ensureDirectoryExist = (baseDir, path) ->
  names = path.split '/'
  names.shift()
  names.pop()  
  
  current = baseDir
  for name in names
    current += "/#{name}"
    try
      fs.lstatSync current
    catch error
      fs.mkdirSync current, 0755

port = 3000
baseDir = "/Users/alex/other_projects/javascript/proxy/files"

# http.createServer((req, res) ->
#   options = 
#     host: 'sd.fortixonline.com'
#     port: 80
#     path: req.url
#     method: req.method
#     # headers: req.headers
#    
#   console.log "proxying #{options.path}"
#   
#   ensureDirectoryExist baseDir, options.path
#   file = fs.createWriteStream "#{baseDir}#{options.path}", flags: 'w', encoding: 'binary'  
#   
#   http.request(options, (pres) ->    
#     res.writeHead 200, pres.headers 
#     pres.on 'data', (chunk) ->
#       # data = "" + chunk
#       file.write chunk, 'binary'
#       fs.writeFile "#{baseDir}#{options.path}.meta", JSON.stringify(pres.headers)
#       
#       res.write chunk, 'binary'      
#     pres.on 'end', ->
#       file?.end()
#       res.end()
#   ).end()
# ).listen port

http.createServer((req, res) ->
  fs.readFile "#{baseDir}#{req.url}", "binary", (error, file) ->
    if error
      res.writeHead 500, "Content-Type": "text/plain"
      res.write error + "\n"
      res.end()
    else
      fs.readFile "#{baseDir}#{req.url}.meta", "binary", (error, metaFile) ->
        headers = JSON.parse metaFile

        res.writeHead 200, headers
        res.write file, "binary"
        res.end()
).listen 3000

console.log "server started on #{port}"