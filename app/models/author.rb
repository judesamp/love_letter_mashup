class Author < ActiveRecord::Base
  has_many :letters, as: :letterable

end