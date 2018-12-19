class Product < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user

  validates :title, presence: { message: "请输入商品名称" }
  validates :price, presence: { message: "请输入商品价格" }
  validates :price, numericality: { greater_than: 0, message: "请输入商品价格，必须大于零" }
  validates :quantity, presence: { message: "请输入库存数量" }, numericality: { greater_than_or_equal: 0 }
  validates_presence_of :user_id
end
