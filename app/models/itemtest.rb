class Itemtest < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
end
