class Person < ActiveRecord::Base
  validates :name, :email, presence: true
  validates :email, confirmation: true
  # better
  # validates :email_confirmation, presence: true
  validates :name, exclusion: { in: %w(admin root) }
  validates :email, format: { with: /\A[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{2,5}\z/, message: 'malformed email address' }
end
