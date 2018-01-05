$(function() {
  $(document).on('turbolinks:load', function() {
    $(".profile").on('click', '.toggle-city', toggleCity)
  })

  var toggleCity = function(e) {
    e.preventDefault();
    var cityPanel = $(this).parents('.panel-city');
    filterCheckboxes = cityPanel.find('.filter-checkbox');
    allChecked = !($(filterCheckboxes).not(':checked').length > 0)
    debugger;
    if (allChecked) {
      filterCheckboxes.each(function(i, box) {
        $(box).prop('checked', false)
      })
    } else {
      filterCheckboxes.each(function(i, box) {
        $(box).prop('checked', true)
      })
    }
  }
})
