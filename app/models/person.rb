class Person < ActiveRecord::Base
  validates :name, :email, presence: true
  validates :email, confirmation: true
  # better
  # validates :email_confirmation, presence: true
  validates :name, exclusion: { in: %w(admin root) }
  validates :email, format: { with: /\A[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{2,5}\z/, message: 'malformed email address' }
  # validates :language, inclusion: { in: I18n.available_locales.map(&:to_s) }
  validates :language, inclusion: { in: %w(ko en jp cn) }
  # length
  # validates :name, length: { minimum: 2, too_short: "at least %{count} words" }
  # validates :name, length: { maximum: 10, too_long: "at most %{count} words"}
  # validates :name, length: { in: 3..7, wrong_length: "out of range" } # not working
  # validates :name, length: { is: 5 }
  validates :name, length: { minimum: 2, tokenizer: lambda { |s| s.scan(/\w+/) } }

  # raise exception
  validates :name, presence: { strict: true }
  # validates :name, presence: { strict: Exception }
end
