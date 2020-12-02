FactoryBot.define do
  factory :exam_window do
    exam
    start_time { DateTime.now - 1.day }
    end_time { DateTime.now + 1.day }
  end
end
