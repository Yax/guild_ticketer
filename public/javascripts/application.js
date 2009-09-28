jQuery.ajaxSetup({ 'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")} });

$(document).ready(function() {

  // load ticket page on tr click
  $("#main table#tickets_list tr").click(function() {
    location.href = admin_ticket_path($(this).attr("id"));
  });

  // load message content
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

  // edit in place for ticket_info
  $("#menu div.ticket_info p.editable").editable(admin_ticket_path($("#menu div.ticket_info").attr("id")), {
    method : 'PUT',
    indicator: '<img src="/images/searching.gif">',
    submitdata : function(value, settings) {
      eval("data = {"+
        "authenticity_token : '" + $("#menu div.ticket_info p#authenticity_token ").text() + "'," +
        "'"+ this.id +"' : value };");
      data.modified = this.id;
      data.value = '';
      data.id = '';
      return data;
    console.log(value);
    }
  });
     


});
