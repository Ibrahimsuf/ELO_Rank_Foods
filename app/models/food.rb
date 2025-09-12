class Food < ApplicationRecord
  attribute :name, :string
  attribute :filename, :file
  attribute :weight, :float
  validates :name, presence: true
  validates :filename, presence: true
end
