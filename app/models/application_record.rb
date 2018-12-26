class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :asc, ->{ order(created_at: :asc) }
  scope :recent, ->{ order(created_at: :desc) }
end
