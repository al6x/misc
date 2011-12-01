
// var http = require('http');
// var sys  = require('sys');
// 
// http.createServer(function(request, response) {
//   sys.log(request.headers['host']);
//   
//   var proxy = http.createClient(80, 'ruby-lang.info')
//   var proxy_request = proxy.request(request.method, request.url, request.headers);
//   proxy_request.addListener('response', function (proxy_response) {
//     proxy_response.addListener('data', function(chunk) {
//       response.write(chunk, 'binary');
//     });
//     proxy_response.addListener('end', function() {
//       response.end();
//     });
//     response.writeHead(proxy_response.statusCode, proxy_response.headers);
//   });
//   
//   request.addListener('data', function(chunk) {
//     proxy_request.write(chunk, 'binary');
//   });
//   request.addListener('end', function() {
//     proxy_request.end();
//   });
// }).listen(4000);

// var EventEmitter = require('events').EventEmitter; 
// var emitter = new EventEmitter; 
// emitter.on('name', function(first, last){ 
//     console.log(first + ', ' + last); 
// }); 
// emitter.emit('name', 'tj', 'holowaychuk'); 
// emitter.emit('name', 'simon', 'holowaychuk'); 

// setInterval(function(){
//   console.log(__dirname); 
// }, 2000);

Proto = {
  implement: function(mixin){
    for(var key in mixin) this.prototype[key] = mixin[key];
  };
};

var Interaction = {move: function(){console.log('moving ...')}}

var Animal = {name: 'Dog'}

var dog = Object.create(null)
dog.prototype.__proto__ = animal

console.log(dog.move)