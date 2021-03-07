class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :delete_all
  belongs_to :user
end
