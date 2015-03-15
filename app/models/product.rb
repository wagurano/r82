class Product < ActiveRecord::Base
  validates :title, :description, :value, presence: true
  validates :value, numericality: { greater_than_or_equal_to: 100, less_than_or_equal_to: 1000 }
  validates :are_you_sure, acceptance: true
end
