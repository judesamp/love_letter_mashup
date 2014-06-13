class LetterOrder < ActiveRecord::Base
  belongs_to :letter
  belongs_to :user
end