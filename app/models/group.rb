class Group < ApplicationRecord
    mount_uploader(:profile_img, SquareUploader)
    serialize :profile_img, JSON
    
    has_many :userlists, dependent: :destroy
    has_many :users, through: :userlists
    has_many :timetables, dependent: :destroy
    has_many :marks, dependent: :destroy
    
    def is_private?
        self.privated
    end
end
