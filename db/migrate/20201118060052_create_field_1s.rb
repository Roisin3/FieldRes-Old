class CreateField1s < ActiveRecord::Migration[6.0]
  def change
    create_table :field_1s do |t|

      t.timestamps
    end
  end
end
