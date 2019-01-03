class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :body, presence: true

  def is_hidden?
    is_hidden
  end

  def publish!
    self.update(is_hidden: false)
  end

  def hide!
    self.update(is_hidden: true)
  end
end
