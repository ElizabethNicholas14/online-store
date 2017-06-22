class Product < ApplicationRecord
  belongs_to :brand, optional:true
  belongs_to :category
  has_many :line_items
  before_destroy :did_anyone_buy_this_product

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :brand_id
#all this comes from the paperclip documentation
  has_attached_file :avatar, styles: {medium: '300x300', thumb:'100x100>'}, default_url: "missing_:style.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates_numericality_of :price,
            greater_than_or_equal_to: 0.01

  validates_numericality_of :quantity,
            greater_than_or_equal_to: 0

  validates :brand, :quantity, presence:true

  #to run an instance method on a class
  def self.search_by_name_or_description(search_term)
    where("name LIKE ? OR description LIKE ?", "%#{search_term}%","%#{search_term}%")

  end

  private
#make sure no one bought this product before we toss it
#if you toss a product that someone hought, their order history will be incorrect and incomplete
  def did_anyone_buy_this_product
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items Present')
      return false
    end
  end


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
