class CreatePetitions < ActiveRecord::Migration
  def change
    create_table :petitions do |t|
      t.string :name
      t.string :description
      t.string :author
      t.timestamps null: false
    end
  end
end
