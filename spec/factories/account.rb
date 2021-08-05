FactoryBot.define do
  factory :account do
    name { "PHAM DUY DY" }
    bank  { "Dy Bank" }

    association :user
  end
end