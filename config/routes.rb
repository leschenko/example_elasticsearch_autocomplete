ExampleElasticsearchAutocomplete::Application.routes.draw do

  root to: 'welcome#index'

  match '/search/autocomplete' => AutocompleteApp

end
