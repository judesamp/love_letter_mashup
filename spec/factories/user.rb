FactoryGirl.define do

  factory :user do |f|

    f.name                  "Joe"
    f.email                 "joe@email.com"
    f.password              "password"
    f.password_confirmation "password"

  end

  factory :invalid_user, class: User do |f|

    f.name                  "Joe"
    f.email                 "joe@email.com"
    f.password              "password"
    f.password_confirmation "passwor"

  end

end


 