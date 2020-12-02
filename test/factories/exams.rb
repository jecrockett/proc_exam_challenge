FactoryBot.define do
  factory :exam do
    college
    name { "Love of Coding Exam" }

    trait :with_exam_window do
      after(:create) { |exam| exam.exam_windows.create(attributes_for(:exam_window)) }
    end
  end
end
