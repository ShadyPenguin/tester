class CreateProficiencies < ActiveRecord::Migration
  def change
    create_table :proficiencies do |t|
      t.integer :years
      t.boolean :formal
      t.belongs_to :user
      t.belongs_to :skill
      t.timestamps
    end
  end
end
