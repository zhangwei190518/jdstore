class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :order_by_created_at_asc, ->{ order(created_at: :asc) }
  scope :order_by_created_at_desc, ->{ order(created_at: :desc) }
end
