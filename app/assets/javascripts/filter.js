$(function() {
  $(document).on('turbolinks:load', function() {
    $(document).off('keyup', filterResults)
    $(document).on('keyup', ".search-filter", filterResults)

    $(document).off('keyup', filterEvents)
    $(document).on('keyup', '.search-events', filterEvents)

    $(document).off('click', '.toggle-city', toggleCity)
    $(document).on('click', '.toggle-city', toggleCity)

    window.searchFilterItems = $(document).find(".search-filter-item")
    window.searchFilterEvents = $(document).find(".event-item")
  })


  var filterResults = function(e) {
    var search = $(this);
    var value = search.val().toLowerCase();

    window.searchFilterItems.each(function(i, item) {
      var labelContent = $(item).text().toLowerCase()
      var panel = $(item).closest('.panel')
      if (!labelContent.includes(value)) {
        $(item).addClass('hidden')
        if ($(item).siblings(':visible').length < 1) {
          $(panel).addClass('hidden')
        }
      } else {
        $(item).removeClass('hidden')
        $(panel).removeClass('hidden')
      }
    })
  }

  var filterEvents = function(e) {
    console.log("filtering...")
    var search = $(this);
    var value = search.val().toLowerCase();

    window.searchFilterEvents.each(function(i, item) {
      var eventContent = $(item).text().toLowerCase()
      var panel = $(item).closest('.panel')
      if (!eventContent.includes(value)) {
        $(item).addClass('hidden')
        if ($(item).siblings(':visible').length < 1) {
          $(panel).addClass('hidden')
        }
      } else {
        $(item).removeClass('hidden')
        $(panel).removeClass('hidden')
      }
    })
  }

  var toggleCity = function(e) {
    e.preventDefault();
    var cityPanel = $(this).parents('.panel-city');
    filterCheckboxes = cityPanel.find('.filter-checkbox');
    allChecked = !($(filterCheckboxes).not(':checked').length > 0)
    if (allChecked) {
      filterCheckboxes.each(function(i, box) {
        $(box).prop('checked', false)
      })
      $(this).find('.glyphicon').removeClass('all-checked').addClass('not-all-checked')
    } else {
      filterCheckboxes.each(function(i, box) {
        $(box).prop('checked', true)
      })
      $(this).find('.glyphicon').removeClass('not-all-checked').addClass('all-checked')
    }
  }
})
