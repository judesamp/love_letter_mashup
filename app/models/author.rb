class Author < ActiveRecord::Base
  has_many :letters
  has_many :snippets

end