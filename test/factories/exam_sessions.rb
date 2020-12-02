FactoryBot.define do
  factory :exam_session do
    exam
    user
    start_time { DateTime.now }
  end
end
