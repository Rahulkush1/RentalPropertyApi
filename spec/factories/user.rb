FactoryBot.define do
  factory :user do
    email {"rahul@gmail.com"}
    password {"password"}
    firts_name {"Rahul"}
    last_name {"Kushwaha"}
    activated {true}
    after(:create) {|user| user.add_role(:admin)}
  end
end