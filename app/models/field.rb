class Field < ActiveRecord::Base
    belongs_to :requirement, optional: true

    
    # has_many :requirements
    # accepts_nested_attributes_for :requirements



end
