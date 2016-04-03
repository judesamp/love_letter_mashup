FactoryGirl.define do 

  factory :letter do |f|
    
    f.content "This is my love letter."
    f.author factory: :author

  end

end


# t.integer  "user_id"
#     t.text     "content"
#     t.integer  "author_id"
#     t.datetime "created_at"
#     t.datetime "updated_at"