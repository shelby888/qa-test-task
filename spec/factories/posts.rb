FactoryGirl.define do
  factory :post do
    title { generate :string }
    body { generate :string }
  end
end
