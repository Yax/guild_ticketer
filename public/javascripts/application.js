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


  /* edit-in-place for ticket_info */
  editable_my_defaults = { placeholder: 'Kliknij aby ustawić',
                           width: '178px',
                           indicator: '<img src="/images/orange_indicator.gif">',
                           method : 'PUT'
                         };
  $.extend($.fn.editable.defaults, editable_my_defaults);

  function editable_set_submitdata(value, settings) {
    field_name = $(this).parent().children("#type").text() + '[' + this.id + ']';
    eval("data = {"+
        "authenticity_token : '" + $("#menu div.ticket_info p#authenticity_token ").text() + "'," +
        "'"+ field_name +"' : value };");
    data.value = '';
    data.id = '';
    return data;
  }

  function editable_onerror(settings, original, xhr) {
    $(original).css('display','none');
    $(original).text(original.revert);
    eval('response = '+xhr.responseText);
    message = '<p class="flash_warning" style="display:none">Pole ';
    message += response[0][0] + ' ' + response[0][1];
    message +='</p>';
    if ( $(original).prev().attr('class') != 'flash_warning' ) {
      $(original).before(message);
    }
    $(original).effect('highlight', {}, 1000);
    $(original).prev().effect('highlight', {}, 3000);
    $(original).prev().effect('blind', {}, 1000);
    original.editing = false;
  }

  function editable_transition_data(value, settings) {
    $(this).html(settings.indicator);
    params = {};
    var content = { '' : this.revert };
    url = transitions_admin_ticket_path($("#menu div.ticket_info").attr("id"));
    params.type = this.id;
    function set_content(val) { $.extend(content, val); }
    $.ajax({ url: url, data: params, async: false, dataType: 'json', success: set_content});
    $(this).html('');
    return content;
  }

  $("#menu div.ticket_info p.editable").editable(admin_ticket_path($("#menu div.ticket_info").attr("id")), {
    submitdata : editable_set_submitdata,
    onerror : editable_onerror
  });

  $("#menu div.ticket_info p.editable_area").editable(admin_ticket_path($("#menu div.ticket_info").attr("id")), {
    type : 'autogrow',
    submit : 'Zatwierdź',
    cancel : 'Anuluj',
    submitdata : editable_set_submitdata,
    onerror : editable_onerror
  });

  $("#menu div.ticket_info p.editable_transition").editable(admin_ticket_path($("#menu div.ticket_info").attr("id")), {
    type : 'select',
    submit : 'OK',
    data : editable_transition_data,
    submitdata : editable_set_submitdata,
    onerror : editable_onerror
  });
  /*********************************/

  /*** New tickets notification ***/
  var is_notification_shown = false;
  var tickets_interval = 10000; //how often check new tickets, in seconds

  function show_new_ticket_notification() {
    warning = '<div id="new_ticket_notification" style="display: none" ';
    warning += 'onclick="location.href=\''+admin_tickets_path()+'?scope=pending\'">';
    warning += 'Nowe<br/>tickety';
    warning += '</div>';
    $('#header').append(warning);
    $('#new_ticket_notification').show('highlight', {color: 'red'}, 3000);
    is_notification_shown = true;
  };

  function check_new_tickets() {
    url = any_new_admin_tickets_path();
    $.get(url, function(res) {
      if (res == 'true') { 
        show_new_ticket_notification();
      }
    });
    if (is_notification_shown == false) {
      setTimeout(check_new_tickets,tickets_interval*1000);
    };
  }
   
  check_new_tickets();
  /********************************/

  /* type filters */
  function getQueryParams(qs) {
    qs = qs.split("+").join(" ");
    var params = {};
    var tokens;

    while (tokens = /[?&]?([^=]+)=([^&]*)/g.exec(qs)) {
      params[decodeURIComponent(tokens[1])] = decodeURIComponent(tokens[2]);
    }

    return params;
  }
  

  $('#menu #types').change(function() {
      params = getQueryParams(location.search);
      params['type'] = this.value;
      params['page'] = '1';
      location.href = admin_tickets_path() +'?'+ $.param(params);
  });


});
