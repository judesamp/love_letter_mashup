class Letter < ActiveRecord::Base
  belongs_to :author
  has_many :letter_orders
  has_many :users, through: :letter_orders
end