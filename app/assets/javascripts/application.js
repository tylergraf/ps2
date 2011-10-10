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
  _this.attr('data-checkin-id', data.id);

}
function send_data(_this,url, type, data, token){
  $.ajax({
    url: url,
    dataType: "json",
    type: type,
    processData: true,
    contentType: "application/json",
    data: data,
    beforeSend: function(xhr) {
      xhr.setRequestHeader("X-CSRF-Token", token);
    },
    success: function(data) {
      update_recorded(_this, data);
    }
  });

}
function prepare_notes_data(_this) {
  console.log(_this);
  var url = '/notes',
      id = _this.attr('data-note-id'),
      date = _this.parent().attr('data-date'),
      notes = _this.parent().find('.notes p').text(),
      user_id = jQuery('[data-user]').attr('data-user');
      data = '{"notes":"'+notes+'","user_id":"' + user_id + '","date":"' + date + '"}',
      type = 'POST',
      token = $('meta[name="csrf-token"]').attr('content');

  if (_this.attr('data-note-recorded') == 'true'){
    url = '/notes/' + id,
    data = '{"notes":"'+notes+'","user_id":"' + user_id + '","id":"' + id + '"}',
    type = 'PUT';
  }
  if(notes !=''){
    send_data(_this,url, type, data, token)
  }
}
function prepare_task_data(_this) {
      if (_this.find('i').hasClass('checked'))
        checked = true;
      else
        checked = false;

      var url = '/check_ins',
      id = _this.attr('data-checkin-id'),
      date = _this.parent().attr('data-date'),
      task_id = _this.attr('data-task-id'),
      total = _this.siblings('.total').text(),
      notes = _this.parent().find('.notes p').text(),
      user_id = jQuery('[data-user]').attr('data-user');
      token = $('meta[name="csrf-token"]').attr('content');
      data = '{"check_in":{"date":"' + date + '","done":'+checked+',' + '"task_ids":"'+ task_id +'","user_id":"' + user_id + '"}}',
      type = 'POST';



  if (_this.attr('data-recorded') == 'true')
    url = '/check_ins/' + id,

            data = '{"date":"' + date + '","done":'+checked+',' + '"task_ids":"'+ task_id +'","id":"' + id + '"}',
            type = 'PUT';

  send_data(_this,url, type, data, token)
}
function close_textarea(_this){

  _this.parent().find('a.cancel').click(function(e){
    e.preventDefault();
    _this.css('display','none');
    jQuery(this).parent().css('display','none');
    _this.siblings('p').css('display','block');
  });

  _this.parent().find('a.button').click(function(e){
      e.preventDefault();
//  _this.live('blur',function(){
      var text = _this.val();
      _this.css('display','none');
      jQuery(this).parent().css('display','none');
      _this.siblings('p').text(text).css('display','block');
      prepare_notes_data(_this.parent());

    });

//  _this.bind('click',create_textarea(jQuery(this)));
}
function create_textarea(_this){
  _this.unbind('click');
  _this.find('p').css('display','none');
  _this.find('.mod-footer').css('display','block');
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
