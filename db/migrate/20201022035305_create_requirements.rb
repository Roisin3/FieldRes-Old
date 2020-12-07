class CreateRequirements < ActiveRecord::Migration[6.0]
  def change
    create_table :requirements do |t|
      t.string :goals
      t.integer :food_truck
      t.text :other
      t.boolean :empty_field
      t.belongs_to :field
      

      t.timestamps
    end
  end
end
