class Field < ActiveRecord::Base
    belongs_to :events, optional: true

    
    has_many :requirements
    accepts_nested_attributes_for :requirements



end
