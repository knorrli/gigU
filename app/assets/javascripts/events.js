$(function() {
  $(document).on('turbolinks:load', function() {
    $(".events").find('.interest-link').on('ajax:success', updateViewstate)
  })

  var updateViewstate = function(event) {
    var detail = event.detail;
    var status = detail[1], xhr = detail[2];
    $(this).toggleClass('interested text-muted');
    $(this).trigger('blur');
  }
})
