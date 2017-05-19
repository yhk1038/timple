class Timetable < ApplicationRecord
    belongs_to :group
    has_many :marks, dependent: :destroy
end
