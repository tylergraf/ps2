// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function update_total(_this) {
  var tasksChecked = _this.find('.checked').length;
  _this.find('.total').text(tasksChecked);
}

function update_recorded(_this, data) {
  _this.attr('data-recorded', 'true');
  _this.attr('class', data.id);

}
function send_data(_this,url, type, data, token){
  $.ajax({
    url: url,
    dataType: "json",
    type: type,
    processData: false,
    contentType: "application/json",
    data: data,
    beforeSend: function(xhr) {
      xhr.setRequestHeader("X-CSRF-Token", token);
    },
    success: function(data) {
      update_recorded(_this.parent(), data);
    }
  });

}
function prepare_notes_data(_this) {
  console.log(_this);
  var url = '/check_ins',
      id = _this.parent().attr('class'),
      date = _this.parent().attr('data-date'),
      task = _this.attr('data-task'),
      total = _this.siblings('.total').text(),
      notes = _this.parent().find('.notes p').text(),
      user_id = jQuery('[data-user]').attr('data-user');
      data = "{\"date\":\"" + date + "\",\"" + task + "\":true,\"notes\":\""+notes+"\",\"read\":true,\"total\":\"" + total + "\",\"user_id\":" + user_id + "}",
      type = 'POST',
      token = $('meta[name="csrf-token"]').attr('content');

  if (_this.find('i').hasClass('checked'))
    checked = true;
  else
    checked = false;

  if (_this.parent('tr').attr('data-recorded'))
    url = '/check_ins/' + id,
            data = '{"date":"' + date + '","id":"' + id + '","' + task + '":' + checked + ',"notes":"'+notes+'","total":"' + total + '","user_id":"' + user_id + '"}',
            type = 'PUT';

  send_data(_this,url, type, data, token)

}
function prepare_task_data(_this) {
  var url = '/check_ins',
      id = _this.parent().attr('class'),
      date = _this.parent().attr('data-date'),
      task = _this.attr('data-task'),
      total = _this.siblings('.total').text(),
      notes = _this.parent().find('.notes p').text(),
      user_id = jQuery('[data-user]').attr('data-user');
      data = "{\"date\":\"" + date + "\",\"" + task + "\":true,\"notes\":\""+notes+"\",\"read\":true,\"total\":\"" + total + "\",\"user_id\":" + user_id + "}",
      type = 'POST',
      token = $('meta[name="csrf-token"]').attr('content');

  if (_this.find('i').hasClass('checked'))
    checked = true;
  else
    checked = false;

  if (_this.parent('tr').attr('data-recorded'))
    url = '/check_ins/' + id,
            data = '{"date":"' + date + '","id":"' + id + '","' + task + '":' + checked + ',"notes":"'+notes+'","total":"' + total + '","user_id":"' + user_id + '"}',
            type = 'PUT';

  send_data(_this,url, type, data, token)
}
function close_textarea(_this){
  _this.live('blur',function(){
    var text = _this.val();
    _this.css('display','none');

    _this.siblings('p').text(text).css('display','block');
    prepare_notes_data(_this.parent());

  });
//  _this.bind('click',create_textarea(jQuery(this)));
}
function create_textarea(_this){
  _this.unbind('click');
  _this.find('p').css('display','none');
  _this.find('textarea').css('display','block');
  _this.find('textarea').focus();
  close_textarea(_this.find('textarea'));
}

jQuery(document).ready(function() {
  jQuery('.task').click(function() {
    var check_obj = jQuery(this).find('i');
    if (check_obj.hasClass('checked')) {
      check_obj.removeClass('checked');
    }
    else {
      check_obj.addClass('checked');
    }
    update_total(jQuery(this).parent());
    prepare_task_data(jQuery(this));

  });
  jQuery('.notes').click(function(){
    create_textarea(jQuery(this));

  });
});
