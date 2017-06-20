class Product < ApplicationRecord
  belongs_to :brand, optional:true
  belongs_to :category

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :brand_id
#all this comes from the paperclip documentation
  has_attached_file :avatar, styles: {medium: '300x300', thumb:'100x100>'}, default_url: "missing_:style.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates :price, numericality:true
  validates :quantity, numericality: {only_integer_true:true}
  validates :brand, :quantity, presence:true


end

# == Schema Information
#
# Table name: products
#
#  id                  :integer          not null, primary key
#  name                :string
#  price               :decimal(, )
#  quantity            :integer
#  description         :text
#  brand_id            :integer
#  category_id         :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#
# Indexes
#
#  index_products_on_brand_id     (brand_id)
#  index_products_on_category_id  (category_id)
#
