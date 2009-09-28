jQuery.ajaxSetup({ 'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")} });

$(document).ready(function() {

  $("#main table#tickets_list tr").click(function() {
    location.href = admin_ticket_path($(this).attr("id"));
  });

  $("#main table#messages_list tr").click(function() {
    row = $(this);
    if ( !row.next().hasClass("message") ) {
      row.after('<tr class="message" style="display: none;"><td colspan="5"></td></tr>');
      $.get(admin_message_path(row.attr("id")), function(message) {
        row.next().children().append(message);
      });
      row.next("tr.message").show();
    } else { 
      row.next("tr.message").toggle();
    };
  });

});


