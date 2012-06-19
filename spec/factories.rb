FactoryGirl.define do
   factory :user do
     name "Iggy Fenton"
     email "iggy@google.com"
     password "iggy123"
     password_confirmation "iggy123"

    factory :admin do
      admin true
    end
   end

  factory :posts do
     content "What up"
    user
  end
end