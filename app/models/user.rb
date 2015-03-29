class User < ActiveRecord::Base
  has_many :assent_date, autosave: true
  validates :username, presence: true
end
