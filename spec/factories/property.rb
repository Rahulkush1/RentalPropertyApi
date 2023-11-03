FactoryBot.define do
  factory :property do
    name {"demo property"}
    status { "available"}
    price {22555}
    prop_type {1}
    publish {"NO"}
    is_paid {false}
    user_id {nil}
   end
end