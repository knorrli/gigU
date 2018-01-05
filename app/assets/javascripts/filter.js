$(function() {
  $(document).on('turbolinks:load', function() {
    $(".filter").on('keyup', ".search-filter", filterResults)
    $(document).on('keyup', '.search-events', filterEvents)
  })

  var searchFilterItems = $(".filter").find(".search-filter-item")
  var searchFilterEvents = $(".event")

  var filterResults = function(e) {
    var search = $(this);
    var value = search.val().toLowerCase();

    searchFilterItems.each(function(i, item) {
      var labelContent = $(item).text().toLowerCase()
      if (!labelContent.includes(value)) {
        $(item).addClass('hidden')
      } else {
        $(item).removeClass('hidden')
      }
    })
  }

  var filterEvents = function(e) {
    var search = $(this);
    var value = search.val().toLowerCase();

    searchFilterEvents.each(function(i, item) {
      var item = $(item)
      var eventContent = item.text().toLowerCase()
      var panel = $(item.closest('.panel'))
      if (!eventContent.includes(value)) {
        item.addClass('hidden')
        if (item.siblings(':visible').length < 1) {
          panel.addClass('hidden')
        }
      } else {
        item.removeClass('hidden')
        panel.removeClass('hidden')
      }
    })
  }
})
