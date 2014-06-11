FactoryGirl.define do 

  factory :letter do |f|
    
    f.content "This is my love letter."
    f.user factory: :user

  end

end


# t.integer  "user_id"
#     t.text     "content"
#     t.integer  "author_id"
#     t.datetime "created_at"
#     t.datetime "updated_at"