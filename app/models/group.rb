class Group < ApplicationRecord
    has_many :users, through: :userlists
    has_many :timetable, dependent: :destroy
    has_many :marks, dependent: :destroy
end
