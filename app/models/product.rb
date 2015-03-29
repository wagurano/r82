class TitleValidator < ActiveModel::EachValidator
  def validate_each record, attribute, value
    record.errors[:title] = "Title must be started with capital." unless value =~ /\A[A-Z]/
  end
end

class Product < ActiveRecord::Base
  validates :description, :value, presence: true
  validates :value, numericality: { greater_than_or_equal_to: 100, less_than_or_equal_to: 1000 }

  # validates :are_you_sure, acceptance: true
  validates :are_you_sure, acceptance: { accept: 'yes' }

  validates :title, presence: true, title: true
end