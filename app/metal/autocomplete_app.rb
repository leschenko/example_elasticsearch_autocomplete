require 'tr_lang'

class AutocompleteApp
  def self.call(env)
    params = Rack::Request.new(env).params
    if params['query'].present?
      entries = Autocomplete.search(params['query'], keyboard_correct: true, kind: params['kind'])
      res = {suggestions: entries, query: params['query']}
      [200, {'Content-Type' => 'application/json'}, res.to_json]
    else
      [204, {}, '']
    end
  end
end
