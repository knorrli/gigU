$(function() {
  $(document).on('turbolinks:load', function() {
    $(document).off('ajax:success', updateViewstate)
    $(document).on('ajax:success', '.interest-link', updateViewstate)
  })

  var updateViewstate = function(event) {
    var detail = event.detail;
    var status = detail[1], xhr = detail[2];
    $(this).toggleClass('interested text-muted');
    $(this).trigger('blur');
  }
})
