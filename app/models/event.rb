class Event < ActiveRecord::Base
    belongs_to :user
    has_many :requirements
    accepts_nested_attributes_for :requirements
end