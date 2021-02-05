class Requirement < ActiveRecord::Base
    belongs_to :event, optional: true

    has_many :fields
    accepts_nested_attributes_for :fields


end
