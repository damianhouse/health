$(document).on('turbolinks:load', function() {
  submitNewMessage();
});

function submitNewMessage(){
  $('textarea#message_body').keypress( function( e ) {
  if( e.keyCode == 13 ) { $(this).closest('form').trigger('submit'); }
} );
}
