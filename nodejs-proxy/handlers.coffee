querystring = require 'querystring'
fs = require 'fs'
formidable = require 'formidable'

exports.start = (req, res) ->
  console.log "start called ..."
  
  res.writeHead 200, "Content-Type": "text/html"
  res.write '''
    <html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    </head>
    <body>
      <form action="/upload" method="post" enctype="multipart/form-data">
        <textarea name="text" rows="20" cols="60"></textarea>
        <input type="file" name="upload">
        <input type="submit" value="Submit" />
      </form>
    </body>
    </html>
  '''
  res.end()
  
exports.upload = (req, res) ->
  console.log "Request handler 'upload' was called."

  form = new formidable.IncomingForm()
  form.parse req, (error, fields, files) ->
    fs.renameSync files.upload.path, "/tmp/test.png"
    res.writeHead 200, "Content-Type": "text/html"
    res.write "received image:<br/>"
    res.write "<img src='/show' />"
    res.end()

exports.show = (req, res) ->
  console.log "Request handler show was called."
  fs.readFile "/tmp/test.png", "binary", (error, file) ->
    if error
      res.writeHead 500, "Content-Type": "text/plain"
      res.write error + "\n"
      res.end()
    else
      res.writeHead 200, "Content-Type": "image/png"
      res.write file, "binary"
      res.end()