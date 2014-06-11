class Letter < ActiveRecord::Base
  belongs_to :user
  belongs_to :author
  belongs_to :letterable, polymorphic: true
end