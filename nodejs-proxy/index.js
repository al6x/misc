(function() {
  var baseDir, ensureDirectoryExist, fs, http, port, url;
  http = require('http');
  url = require('url');
  fs = require('fs');
  ensureDirectoryExist = function(baseDir, path) {
    var current, name, names, _i, _len, _results;
    names = path.split('/');
    names.shift();
    names.pop();
    current = baseDir;
    _results = [];
    for (_i = 0, _len = names.length; _i < _len; _i++) {
      name = names[_i];
      current += "/" + name;
      _results.push((function() {
        try {
          return fs.lstatSync(current);
        } catch (error) {
          return fs.mkdirSync(current, 0755);
        }
      })());
    }
    return _results;
  };
  port = 3000;
  baseDir = "/Users/alex/other_projects/javascript/proxy/files";
  http.createServer(function(req, res) {
    return fs.readFile("" + baseDir + req.url, "binary", function(error, file) {
      if (error) {
        res.writeHead(500, {
          "Content-Type": "text/plain"
        });
        res.write(error + "\n");
        return res.end();
      } else {
        return fs.readFile("" + baseDir + req.url + ".meta", "binary", function(error, metaFile) {
          var headers;
          headers = JSON.parse(metaFile);
          res.writeHead(200, headers);
          res.write(file, "binary");
          return res.end();
        });
      }
    });
  }).listen(3000);
  console.log("server started on " + port);
}).call(this);
