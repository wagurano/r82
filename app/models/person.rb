class Person < ActiveRecord::Base
  validates :name, :email, presence: true
  validates :email, confirmation: true
  # better
  # validates :email_confirmation, presence: true
  validates :name, exclusion: { in: %w(admin root) }
end
