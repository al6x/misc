(function() {
  var formidable, fs, querystring;
  querystring = require('querystring');
  fs = require('fs');
  formidable = require('formidable');
  exports.start = function(req, res) {
    console.log("start called ...");
    res.writeHead(200, {
      "Content-Type": "text/html"
    });
    res.write('<html>\n<head>\n  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />\n</head>\n<body>\n  <form action="/upload" method="post" enctype="multipart/form-data">\n    <textarea name="text" rows="20" cols="60"></textarea>\n    <input type="file" name="upload">\n    <input type="submit" value="Submit" />\n  </form>\n</body>\n</html>');
    return res.end();
  };
  exports.upload = function(req, res) {
    var form;
    console.log("Request handler 'upload' was called.");
    form = new formidable.IncomingForm();
    return form.parse(req, function(error, fields, files) {
      fs.renameSync(files.upload.path, "/tmp/test.png");
      res.writeHead(200, {
        "Content-Type": "text/html"
      });
      res.write("received image:<br/>");
      res.write("<img src='/show' />");
      return res.end();
    });
  };
  exports.show = function(req, res) {
    console.log("Request handler show was called.");
    return fs.readFile("/tmp/test.png", "binary", function(error, file) {
      if (error) {
        res.writeHead(500, {
          "Content-Type": "text/plain"
        });
        res.write(error + "\n");
        return res.end();
      } else {
        res.writeHead(200, {
          "Content-Type": "image/png"
        });
        res.write(file, "binary");
        return res.end();
      }
    });
  };
}).call(this);
