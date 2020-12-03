class Field < ApplicationRecord
    belongs_to :event
    has_many :requirements

    validate :exclusive_field

    def exclusive_field?
        result = true
        reserved = {}
        
        @field = @field.find_by(:name params[:name])
        @field.pluck(:start, :finish).each do |date_range|
            (date_range.first..date_range.second).each do |date|
                reserved[date] = true
            end
        end

        if reserved.has_key? self.date_start
            errors.add(:date_start, 'it overlaps another reservation')
            result = false
        end

        result
    end
end
