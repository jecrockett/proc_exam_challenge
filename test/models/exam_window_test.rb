require 'test_helper'

class ExamWindowTest < ActiveSupport::TestCase
  describe 'ExamWindow' do
    let(:exam_window) do
      build(
        :exam_window,
        exam: create(:exam),
        start_time: Time.now,
        end_time: Time.now + 1.day
      )
    end

    it 'is valid with all attributes' do
      assert exam_window.valid?
    end

    it 'is valid with just a start date' do
      exam_window.end_time = nil

      assert exam_window.valid?
    end

    it 'must have a start date' do
      exam_window.start_time = nil

      assert exam_window.invalid?
    end

    it 'must belong to an exam' do
      exam_window.exam = nil

      assert exam_window.invalid?
    end
  end
end
