FactoryGirl.define do 

  factory :snippet do |f|
    
    f.content "This is my love letter snippet."
    f.author factory: :author

  end

end