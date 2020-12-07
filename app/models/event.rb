class Event < ActiveRecord::Base
    belongs_to :user

    has_many :fields
    accepts_nested_attributes_for :fields


# Needs to check all Events with matching Field.name 
# for overlapping start and finish datetimes.
# arguement should be the created event's field.name
#
#
#
    def exclusive_field
        field_arr = []        
        field_arr << Field.where("name == 1").find_each
        
    end
        

end