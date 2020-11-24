class Field2 < ApplicationRecord
    has_many :events
    validate :exclusive_reservation?

    def exclusive_field?
        result = true
        reserved = {}

        Field2.pluck(:start, :finish).each do |date_range|
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
