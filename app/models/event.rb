class Event < ActiveRecord::Base
    belongs_to :users
    has_many :requirements
    accepts_nested_attributes_for :requirements
end