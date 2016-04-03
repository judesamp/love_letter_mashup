FactoryGirl.define do 

  factory :letter_order do |f|
    
    f.recipient_email "This is my love letter."
    f.recipient_name "Joe"
    f.signature "Jane"
    f.letter factory: :letter
    f.user factory: :user

  end

end