require 'test_helper'

class ExamSessionTest < ActiveSupport::TestCase
  describe 'ExamSession' do
    let(:exam_session) do
      build(
        :exam_session,
        exam: create(:exam, :with_exam_window),
        user: create(:user),
        start_time: DateTime.now
      )
    end

    it 'is valid with all attributes' do
      assert exam_session.valid?
    end

    it 'must have an exam' do
      exam_session.exam = nil

      assert exam_session.invalid?
    end

    it 'must have a user' do
      exam_session.user = nil

      assert exam_session.invalid?
    end

    describe 'start time' do
      it 'must exist' do
        exam_session.start_time = nil

        assert exam_session.invalid?
      end

      it 'must fall within the range of an exam window' do
        # default exam window provided by factory is +/- 1 day
        invalid_times = [ 2.days.ago, 2.days.from_now ]

        assert invalid_times.all? do |start_time|
          exam_session.start_time = start_time
          exam_session.invalid?
        end
      end

      it 'plays nice with open exam windows (those with no end time)' do
        exam_session.exam.exam_windows.first.update(end_time: nil)

        assert exam_session.valid?
      end
    end
  end
end
