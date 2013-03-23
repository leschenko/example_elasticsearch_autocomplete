require 'word_count'
class Autocomplete < ActiveRecord::Base
  ac_field :term

  def to_indexed_json
    {term: term, freq: freq}.to_json
  end

  def self.search(query)
    return [] if query.blank?
    ac_search(query, order: 'freq', sort_mode: 'desc').map(&:term).uniq
  end

  def self.perform
    columns = [:term, :freq]
    words = []

    Autocomplete.delete_all('is_index=TRUE')

    # some model related imports
    #[[Post.visible, :title], [Tag, :name]].each do |m|
    #  words += m[0].const_get(:Translation).pluck(m[1])
    #end
    #
    #words += User.persons.map(&:full_name)

    100.times do
      words << Forgery::Name.full_name
      words << Forgery::Name.company_name
    end

    import(columns, words.compact.word_count.to_a)
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

