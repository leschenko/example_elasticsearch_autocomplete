class CreateAutocompletes < ActiveRecord::Migration
  def change
    create_table :autocompletes do |t|
      t.string :term
      t.integer :freq
      t.boolean :is_index, default: true, null: false

      t.timestamps
    end
  end
end
