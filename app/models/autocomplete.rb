require 'word_count'

class Autocomplete < ActiveRecord::Base
  ac_field :term
  
  mapping do
    indexes :freq, type: 'integer'
  end

  def to_indexed_json
    {term: term, freq: freq}.to_json
  end

  def self.search(query, params={})
    return [] if query.blank?
    options = {order: 'freq', sort_mode: 'desc', per_page: params[:per_page]}
    results = perform(query, options)
    results = perform(query.tr_lang, options) if results.empty? && params[:keyboard_correct]
    results
  end


  def self.perform(query, options)
    ac_search(query, options).map(&:term).uniq
  end

  def self.populate
    columns = [:term, :freq]
    words = []

    Autocomplete.delete_all

    # some model related imports
    # [[Post.visible, :title], [Tag, :name]].each do |m|
    #   words += m[0].const_get(:Translation).pluck(m[1])
    # end
    #
    # words += User.all.map(&:full_name)

    100.times do
      words << Forgery::Name.full_name
      words << Forgery::Name.company_name
    end

    import(columns, words.compact.word_count.to_a)
    tire.import(per_page: 10_000)
    count
  end

end

# == Schema Information
#
# Table name: autocompletes
#
#  id         :integer          not null, primary key
#  term       :string(255)
#  freq       :integer
#  is_index   :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

