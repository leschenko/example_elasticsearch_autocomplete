ExampleElasticsearchAutocomplete::Application.routes.draw do

  root to: 'welcome#index'

  get '/search/autocomplete' => AutocompleteApp

end
