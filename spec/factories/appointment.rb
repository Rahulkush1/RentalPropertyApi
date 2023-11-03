FactoryBot.define do
  factory :appointment do
    name {"demo"}
    email {"abcd@gmail.com"}
    phone { 12345}
    user_id {nil}
    property_id {nil}
   end
end