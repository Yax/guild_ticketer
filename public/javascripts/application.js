jQuery.ajaxSetup({ 'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")} });

$(document).ready(function() {
  $("#main table tr").click(function() {
    location.href = admin_ticket_path($(this).attr("id"));
    });
});


