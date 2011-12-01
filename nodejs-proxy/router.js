(function() {
  exports.route = function(routes, path, data, res) {
    if (routes[path]) {
      return routes[path](data, res);
    } else {
      return console.log("no handler for " + path + "!");
    }
  };
}).call(this);
