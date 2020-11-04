class CreateRequirements < ActiveRecord::Migration[6.0]
  def change
    create_table :requirements do |t|
      t.string :field
      t.string :goals
      t.integer :food_truck
      t.text :other
      t.boolean :empty_field
      t.belongs_to :user
      t.belongs_to :event
      

      t.timestamps
    end
  end
end
