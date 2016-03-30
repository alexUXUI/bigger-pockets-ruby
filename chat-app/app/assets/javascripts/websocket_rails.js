// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

//= require websocket_rails/main

var dispatcher = new WebSocketRails('localhost:3000/websocket');

dispatcher.on_open = function(data) {
  console.log('Connection has been established: ', data);
  // You can trigger new server events inside this callback if you wish.
};

dispatcher.bind('new_user', function(data) {
  console.log(data.message); // would output 'this is a message'
  console.log('new user onboard');
});

function sendMessage(){
  var message = {};
  message.text = $('#messageText').val()
  message.name = $('#nameText').val()
  dispatcher.trigger('new_message', message)
  console.log(message.text, message.name);
}

$(document).ready(function(){
  $('.submit-button').on('click', function(){
    sendMessage();
    console.log('hitting send');
  })
})
