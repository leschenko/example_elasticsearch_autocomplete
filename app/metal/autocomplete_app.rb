# -*- encoding : utf-8 -*-
require 'tr_lang'

class AutocompleteApp
  def self.call(env)
    params = Rack::Request.new(env).params
    q = params['query']
    if q.present?
      entries = Autocomplete.search(q)

      # switch to another language if no results found
      if entries.empty?
        entries = Autocomplete.search(q.tr_lang)
      end

      if entries.size.zero?
        words = q.split(/\s+/)
        words.each_with_index do |w, i|
          next if i.zero?
          w_entries = Autocomplete.search(w)
          w_entries.each do |w_e|
            entries << words.dup.tap{|ws| ws[i] = w_e }.join(' ')
          end
        end
      end
      
      res = {suggestions: entries, query: q}
      [200, {'Content-Type' => 'application/json'}, res.to_json]
    else
      [404, {'Content-Type' => 'text/html'}, ['Not Found']]
    end
  end
end
