class Requirement < ActiveRecord::Base
    belongs_to :field, optional: true


end
