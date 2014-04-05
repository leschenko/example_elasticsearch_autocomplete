class CreateAutocompletes < ActiveRecord::Migration
  def change
    create_table :autocompletes do |t|
      t.string :term
      t.integer :freq

      t.timestamps
    end
  end
end
