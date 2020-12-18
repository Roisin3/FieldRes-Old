class Event < ActiveRecord::Base
    validates :title, presence: true
    belongs_to :user

    has_many :fields
    accepts_nested_attributes_for :fields
        
    
    scope :field_finder, ->(field_name) { joins(:fields).where("fields.name == ?", field_name )}
    

   

end