#= require jquery
#= require jquery_ujs
#= require jquery.autocomplete

$ ->
  $('#q').autocomplete
    serviceUrl: '/search/autocomplete',
    minChars: 2,
    maxHeight: 800,
    onSelect: -> $('#search_form').submit()

  $('input[type="text"],input[type="string"],select:visible,textarea:visible', $('form:last')).get(0)?.focus()
