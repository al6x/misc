(function() {
  var file, static;
  static = require('node-static');
  file = new static.Server('./files');
  require('http').createServer(function(request, response) {
    return request.addListener('end', function() {
      return file.serve(request, response);
    });
  }).listen(3000);
}).call(this);
