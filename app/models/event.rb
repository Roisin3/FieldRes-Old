class Event < ActiveRecord::Base
    belongs_to :user

    has_many :fields
    accepts_nested_attributes_for :fields
        

end