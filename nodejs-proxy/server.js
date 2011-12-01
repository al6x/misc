(function() {
  exports.start = function(route, routes) {
    var http, querystring, url;
    http = require('http');
    url = require('url');
    querystring = require('querystring');
    http.createServer(function(req, res) {
      var path;
      path = url.parse(req.url).pathname;
      console.log("processing " + path);
      return route(routes, path, req, res);
    }).listen(3000);
    return console.log("Server started");
  };
}).call(this);
