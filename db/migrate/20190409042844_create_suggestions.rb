class CreateSuggestions < ActiveRecord::Migration[5.2]
  def change
    create_table :suggestions do |t|
      t.string :name
      t.boolean :classify
      t.text :message
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
