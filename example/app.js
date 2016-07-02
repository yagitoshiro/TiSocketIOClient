// This is a test harness for your module
// You should do something interesting in this harness
// to test out the module and to provide instructions
// to users on how to use it by example.


// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
var label = Ti.UI.createLabel({text: "Hello"});
win.add(label);
win.open();

// TODO: write your module tests here
var socket, io;

io = require('ro.toshi.ti.mod.tisocketio');
socket = io.createSocket({
  url: 'http://localhost:9999/'
});

socket.on('connect', function(){
  label.text = "connected";
  socket.emit('message', {message: "hi"});
});

socket.on('serverPush', function(e){
  label.text = e.message;
});

socket.connect();

win.addEventListener('close', function(){
  socket.disconnect();
});
