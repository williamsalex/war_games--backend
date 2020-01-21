class Deck < ApplicationRecord
    has_many :players
    belongs_to :user
end