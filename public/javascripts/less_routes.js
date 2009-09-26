function less_json_eval(json){return eval('(' +  json + ')')}  

function jq_defined(){return typeof(jQuery) != "undefined"}

function less_get_params(obj){
   
  if (jq_defined()) { return obj }
  if (obj == null) {return '';}
  var s = [];
  for (prop in obj){
    s.push(prop + "=" + obj[prop]);
  }
  return s.join('&') + '';
}

function less_merge_objects(a, b){
   
  if (b == null) {return a;}
  z = new Object;
  for (prop in a){z[prop] = a[prop]}
  for (prop in b){z[prop] = b[prop]}
  return z;
}

function less_ajax(url, verb, params, options){
   
  if (verb == undefined) {verb = 'get';}
  var res;
  if (jq_defined()){
    v = verb.toLowerCase() == 'get' ? 'GET' : 'POST'
    if (verb.toLowerCase() == 'get' || verb.toLowerCase() == 'post'){p = less_get_params(params);}
    else{p = less_get_params(less_merge_objects({'_method': verb.toLowerCase()}, params))} 
     
     
    res = jQuery.ajax(less_merge_objects({async:false, url: url, type: v, data: p}, options)).responseText;
  } else {  
    new Ajax.Request(url, less_merge_objects({asynchronous: false, method: verb, parameters: less_get_params(params), onComplete: function(r){res = r.responseText;}}, options));
  }
  if (url.indexOf('.json') == url.length-5){ return less_json_eval(res);}
  else {return res;}
}
function less_ajaxx(url, verb, params, options){
   
  if (verb == undefined) {verb = 'get';}
  if (jq_defined()){
    v = verb.toLowerCase() == 'get' ? 'GET' : 'POST'
    if (verb.toLowerCase() == 'get' || verb.toLowerCase() == 'post'){p = less_get_params(params);}
    else{p = less_get_params(less_merge_objects({'_method': verb.toLowerCase()}, params))} 
     
     
    jQuery.ajax(less_merge_objects({ url: url, type: v, data: p, complete: function(r){eval(r.responseText)}}, options));
  } else {  
    new Ajax.Request(url, less_merge_objects({method: verb, parameters: less_get_params(params), onComplete: function(r){eval(r.responseText);}}, options));
  }
}
function admin_categories_path(format, verb){ return '/admin/categories' + format + '';}
function admin_categories_ajax(format, verb, params, options){ return less_ajax('/admin/categories' + format + '', verb, params, options);}
function admin_categories_ajaxx(format, verb, params, options){ return less_ajaxx('/admin/categories' + format + '', verb, params, options);}
function new_admin_category_path(format, verb){ return '/admin/categories/new' + format + '';}
function new_admin_category_ajax(format, verb, params, options){ return less_ajax('/admin/categories/new' + format + '', verb, params, options);}
function new_admin_category_ajaxx(format, verb, params, options){ return less_ajaxx('/admin/categories/new' + format + '', verb, params, options);}
function edit_admin_category_path(id, format, verb){ return '/admin/categories/' + id + '/edit' + format + '';}
function edit_admin_category_ajax(id, format, verb, params, options){ return less_ajax('/admin/categories/' + id + '/edit' + format + '', verb, params, options);}
function edit_admin_category_ajaxx(id, format, verb, params, options){ return less_ajaxx('/admin/categories/' + id + '/edit' + format + '', verb, params, options);}
function admin_category_path(id, format, verb){ return '/admin/categories/' + id + '' + format + '';}
function admin_category_ajax(id, format, verb, params, options){ return less_ajax('/admin/categories/' + id + '' + format + '', verb, params, options);}
function admin_category_ajaxx(id, format, verb, params, options){ return less_ajaxx('/admin/categories/' + id + '' + format + '', verb, params, options);}
function admin_ticket_messages_path(ticket_id, format, verb){ return '/admin/tickets/' + ticket_id + '/messages' + format + '';}
function admin_ticket_messages_ajax(ticket_id, format, verb, params, options){ return less_ajax('/admin/tickets/' + ticket_id + '/messages' + format + '', verb, params, options);}
function admin_ticket_messages_ajaxx(ticket_id, format, verb, params, options){ return less_ajaxx('/admin/tickets/' + ticket_id + '/messages' + format + '', verb, params, options);}
function new_admin_ticket_message_path(ticket_id, format, verb){ return '/admin/tickets/' + ticket_id + '/messages/new' + format + '';}
function new_admin_ticket_message_ajax(ticket_id, format, verb, params, options){ return less_ajax('/admin/tickets/' + ticket_id + '/messages/new' + format + '', verb, params, options);}
function new_admin_ticket_message_ajaxx(ticket_id, format, verb, params, options){ return less_ajaxx('/admin/tickets/' + ticket_id + '/messages/new' + format + '', verb, params, options);}
function edit_admin_message_path(id, format, verb){ return '/admin/messages/' + id + '/edit' + format + '';}
function edit_admin_message_ajax(id, format, verb, params, options){ return less_ajax('/admin/messages/' + id + '/edit' + format + '', verb, params, options);}
function edit_admin_message_ajaxx(id, format, verb, params, options){ return less_ajaxx('/admin/messages/' + id + '/edit' + format + '', verb, params, options);}
function admin_message_path(id, format, verb){ return '/admin/messages/' + id + '' + format + '';}
function admin_message_ajax(id, format, verb, params, options){ return less_ajax('/admin/messages/' + id + '' + format + '', verb, params, options);}
function admin_message_ajaxx(id, format, verb, params, options){ return less_ajaxx('/admin/messages/' + id + '' + format + '', verb, params, options);}
function admin_tickets_path(format, verb){ return '/admin/tickets' + format + '';}
function admin_tickets_ajax(format, verb, params, options){ return less_ajax('/admin/tickets' + format + '', verb, params, options);}
function admin_tickets_ajaxx(format, verb, params, options){ return less_ajaxx('/admin/tickets' + format + '', verb, params, options);}
function new_admin_ticket_path(format, verb){ return '/admin/tickets/new' + format + '';}
function new_admin_ticket_ajax(format, verb, params, options){ return less_ajax('/admin/tickets/new' + format + '', verb, params, options);}
function new_admin_ticket_ajaxx(format, verb, params, options){ return less_ajaxx('/admin/tickets/new' + format + '', verb, params, options);}
function edit_admin_ticket_path(id, format, verb){ return '/admin/tickets/' + id + '/edit' + format + '';}
function edit_admin_ticket_ajax(id, format, verb, params, options){ return less_ajax('/admin/tickets/' + id + '/edit' + format + '', verb, params, options);}
function edit_admin_ticket_ajaxx(id, format, verb, params, options){ return less_ajaxx('/admin/tickets/' + id + '/edit' + format + '', verb, params, options);}
function admin_ticket_path(id, format, verb){ return '/admin/tickets/' + id + '' + format + '';}
function admin_ticket_ajax(id, format, verb, params, options){ return less_ajax('/admin/tickets/' + id + '' + format + '', verb, params, options);}
function admin_ticket_ajaxx(id, format, verb, params, options){ return less_ajaxx('/admin/tickets/' + id + '' + format + '', verb, params, options);}
function admin_complaint_messages_path(complaint_id, format, verb){ return '/admin/tickets/' + complaint_id + '/messages' + format + '';}
function admin_complaint_messages_ajax(complaint_id, format, verb, params, options){ return less_ajax('/admin/tickets/' + complaint_id + '/messages' + format + '', verb, params, options);}
function admin_complaint_messages_ajaxx(complaint_id, format, verb, params, options){ return less_ajaxx('/admin/tickets/' + complaint_id + '/messages' + format + '', verb, params, options);}
function new_admin_complaint_message_path(complaint_id, format, verb){ return '/admin/tickets/' + complaint_id + '/messages/new' + format + '';}
function new_admin_complaint_message_ajax(complaint_id, format, verb, params, options){ return less_ajax('/admin/tickets/' + complaint_id + '/messages/new' + format + '', verb, params, options);}
function new_admin_complaint_message_ajaxx(complaint_id, format, verb, params, options){ return less_ajaxx('/admin/tickets/' + complaint_id + '/messages/new' + format + '', verb, params, options);}
function admin_complaints_path(format, verb){ return '/admin/tickets' + format + '';}
function admin_complaints_ajax(format, verb, params, options){ return less_ajax('/admin/tickets' + format + '', verb, params, options);}
function admin_complaints_ajaxx(format, verb, params, options){ return less_ajaxx('/admin/tickets' + format + '', verb, params, options);}
function new_admin_complaint_path(format, verb){ return '/admin/tickets/new' + format + '';}
function new_admin_complaint_ajax(format, verb, params, options){ return less_ajax('/admin/tickets/new' + format + '', verb, params, options);}
function new_admin_complaint_ajaxx(format, verb, params, options){ return less_ajaxx('/admin/tickets/new' + format + '', verb, params, options);}
function edit_admin_complaint_path(id, format, verb){ return '/admin/tickets/' + id + '/edit' + format + '';}
function edit_admin_complaint_ajax(id, format, verb, params, options){ return less_ajax('/admin/tickets/' + id + '/edit' + format + '', verb, params, options);}
function edit_admin_complaint_ajaxx(id, format, verb, params, options){ return less_ajaxx('/admin/tickets/' + id + '/edit' + format + '', verb, params, options);}
function admin_complaint_path(id, format, verb){ return '/admin/tickets/' + id + '' + format + '';}
function admin_complaint_ajax(id, format, verb, params, options){ return less_ajax('/admin/tickets/' + id + '' + format + '', verb, params, options);}
function admin_complaint_ajaxx(id, format, verb, params, options){ return less_ajaxx('/admin/tickets/' + id + '' + format + '', verb, params, options);}
function client_tickets_path(format, verb){ return '/client/tickets' + format + '';}
function client_tickets_ajax(format, verb, params, options){ return less_ajax('/client/tickets' + format + '', verb, params, options);}
function client_tickets_ajaxx(format, verb, params, options){ return less_ajaxx('/client/tickets' + format + '', verb, params, options);}
function client_new_ticket_path(format, verb){ return '/client/tickets/new' + format + '';}
function client_new_ticket_ajax(format, verb, params, options){ return less_ajax('/client/tickets/new' + format + '', verb, params, options);}
function client_new_ticket_ajaxx(format, verb, params, options){ return less_ajaxx('/client/tickets/new' + format + '', verb, params, options);}
function client_ticket_path(id, format, verb){ return '/client/tickets/' + id + '' + format + '';}
function client_ticket_ajax(id, format, verb, params, options){ return less_ajax('/client/tickets/' + id + '' + format + '', verb, params, options);}
function client_ticket_ajaxx(id, format, verb, params, options){ return less_ajaxx('/client/tickets/' + id + '' + format + '', verb, params, options);}
function client_message_path(id, format, verb){ return '/client/messages/' + id + '' + format + '';}
function client_message_ajax(id, format, verb, params, options){ return less_ajax('/client/messages/' + id + '' + format + '', verb, params, options);}
function client_message_ajaxx(id, format, verb, params, options){ return less_ajaxx('/client/messages/' + id + '' + format + '', verb, params, options);}
function client_ticket_messages_path(id, format, verb){ return '/client/tickets/' + id + '/messages' + format + '';}
function client_ticket_messages_ajax(id, format, verb, params, options){ return less_ajax('/client/tickets/' + id + '/messages' + format + '', verb, params, options);}
function client_ticket_messages_ajaxx(id, format, verb, params, options){ return less_ajaxx('/client/tickets/' + id + '/messages' + format + '', verb, params, options);}
function client_new_message_path(id, format, verb){ return '/client/ticket/' + id + '/messages/new' + format + '';}
function client_new_message_ajax(id, format, verb, params, options){ return less_ajax('/client/ticket/' + id + '/messages/new' + format + '', verb, params, options);}
function client_new_message_ajaxx(id, format, verb, params, options){ return less_ajaxx('/client/ticket/' + id + '/messages/new' + format + '', verb, params, options);}
