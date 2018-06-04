class Post < ApplicationRecord
    resourcify
    include Authority::Abilities
    has_many :comments, dependent: :destroy
    belongs_to :user
end
