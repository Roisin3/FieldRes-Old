class CreateFields < ActiveRecord::Migration[6.0]
  def change
    create_table :fields do |t|
      t.string :name
      t.belongs_to :requirement

      t.timestamps
    end
  end
end
