class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.datetime :start
      t.datetime :finish
      t.string :title
      t.belongs_to :user
      t.belongs_to :field_1
      t.belongs_to :field_2
      t.belongs_to :field_3

      t.timestamps
    end

=begin
    create_table :reservations do |t|
      t.integer :event_id
      t.string :subject_type
      t.integer :subject_id
      t.string :status
      t.string :role

      t.timestamps
    end
=end

  end
end
