FactoryBot.define do
  sequence(:email) { |n| "email#{n}@example.com" }
  sequence(:name) { |n| "Name #{n}" }
end
