FactoryBot.define do
  factory :college do
    sequence(:name) { |n| "Turing School #{n}" }
  end
end
