class AbsentDate < ActiveRecord::Base
  # 1
  # belongs_to :user, autosave: true, validate: true

  # 2
  belongs_to :user
  validates_associated :user
end
