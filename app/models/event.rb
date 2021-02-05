class Event < ActiveRecord::Base
    validates :title, presence: true
    belongs_to :user

    has_many :requirements
    accepts_nested_attributes_for :requirements

    has_many :fields, through: :requirements, class_name: 'field'
    #accepts_nested_attributes_for :fields
     
    scope :user_id_finder, ->(user_id) { where("user_id == ?", user_id )}   
    
    scope :field_finder, ->(field_name) { joins(requirements: [:fields]).where("fields.name == ?", field_name )}
    

   

end