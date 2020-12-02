FactoryBot.define do
  factory :user do
    first_name { 'Test' }
    last_name { 'User' }
    sequence(:phone_number) do |n|
      # ensure unique 10 digit number
      n_length = n.digits.length
      "#{n}#{rand(10**(9 - n_length)...10**(10 - n_length))}"
    end
  end
end