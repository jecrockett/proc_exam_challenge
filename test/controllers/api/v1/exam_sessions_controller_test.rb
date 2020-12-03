require 'test_helper'

class ExamSessionControllerTest < ActionDispatch::IntegrationTest
  describe '#create' do
    let(:college) { create(:college) }
    let(:exam) { create(:exam, :with_exam_window, college: college) }
    let(:valid_params) do
      {
        first_name: 'jamie',
        last_name: 'lastname',
        phone_number: '2223334444',
        college_id: college.id,
        exam_id: exam.id,
        start_time: Time.now,
      }
    end

    describe 'successful requests' do
      it 'creates an ExamSession and returns a 200 OK response' do
        assert_difference -> { ExamSession.count } do
          post api_v1_exam_sessions_path({ params: valid_params })
        end

        assert_response :success
      end

      it 'finds an existing user by phone_number, last_name, and first_name' do
        existing_user = User.create(valid_params.slice(:phone_number, :last_name, :first_name))

        assert_no_difference -> { User.count } do
          post api_v1_exam_sessions_path({ params: valid_params })
        end

        assert_equal existing_user, ExamSession.last.user
        assert_response :success
      end

      it 'creates a new user if it does not find an existing one matching all three user fields' do
        different_first = User.create(first_name: 'DIFFERENT', **valid_params.slice(:phone_number, :last_name))
        different_last = User.create(last_name: 'DIFFERENT', **valid_params.slice(:phone_number, :first_name))
        different_phone = User.create(phone_number: '9998887777', **valid_params.slice(:first_name, :last_name))

        assert_difference -> { User.count } do
          post api_v1_exam_sessions_path({ params: valid_params })
        end

        refute_includes [different_first, different_last, different_phone], ExamSession.last.user
        assert_response :success
      end
    end

    describe 'unsuccessful requests' do
      it 'returns a 400 response with invalid data' do
        assert_no_difference -> { ExamSession.count } do
          post api_v1_exam_sessions_path({ params: { i_love_dogs: true }})
        end

        assert_response :bad_request
      end

      it 'cannot have a blank college_id' do
        missing_college_id = valid_params.merge({ college_id: nil })

        assert_no_difference -> { ExamSession.count } do
          post api_v1_exam_sessions_path({ params: missing_college_id})
        end

        assert_response :bad_request
        assert_includes response.parsed_body, 'The provided college_id is not found'
      end

      it 'cannot have an invalid college_id' do
        invalid_college_id = valid_params.merge({ college_id: 91919191919191 })

        assert_no_difference -> { ExamSession.count } do
          post api_v1_exam_sessions_path({ params: invalid_college_id})
        end

        assert_response :bad_request
        assert_includes response.parsed_body, 'The provided college_id is not found'
      end

      it 'cannot be missing an exam_id' do
        missing_exam_id = valid_params.merge({ exam_id: nil })

        assert_no_difference -> { ExamSession.count } do
          post api_v1_exam_sessions_path({ params: missing_exam_id})
        end

        assert_response :bad_request
        assert_includes response.parsed_body, "The requested exam is not found or not offered by the provided college"
      end

      it 'must have an exam_id that belongs to the provided college_id' do
        mismatch_exam_id = valid_params.merge({ exam_id: create(:exam).id })

        assert_no_difference -> { ExamSession.count } do
          post api_v1_exam_sessions_path({ params: mismatch_exam_id})
        end

        assert_response :bad_request
        assert_includes response.parsed_body, "The requested exam is not found or not offered by the provided college"
      end

      it 'must have a last name' do
        invalid_last_name = valid_params.merge(last_name: nil)

        assert_no_difference -> { ExamSession.count } do
          post api_v1_exam_sessions_path({ params: invalid_last_name})
        end

        assert_response :bad_request
        assert_includes response.parsed_body, "Last name can't be blank"
      end

      it 'cannot have a blank phone number' do
        invalid_phone = valid_params.merge(phone_number: nil)

        assert_no_difference -> { ExamSession.count } do
          post api_v1_exam_sessions_path({ params: invalid_phone})
        end

        assert_response :bad_request
        assert_includes response.parsed_body, "Phone number is invalid"
      end

      it 'must have a valid phone number' do
        invalid_phone = valid_params.merge(phone_number: '555666777') # phone number is too short

        assert_no_difference -> { ExamSession.count } do
          post api_v1_exam_sessions_path({ params: invalid_phone})
        end

        assert_response :bad_request
        assert_includes response.parsed_body, "Phone number is invalid"
      end

      it 'cannot have a blank start time' do
        invalid_start_time = valid_params.merge({ start_time: nil })

        assert_no_difference -> { ExamSession.count } do
          post api_v1_exam_sessions_path({ params: invalid_start_time})
        end

        assert_response :bad_request
        assert_includes response.parsed_body, "Start time can't be blank"
      end

      it 'must have a start time within the exam window for the exam' do
        invalid_start_time = valid_params.merge({ start_time: 3.days.from_now }) # default window is +/- 1 day

        assert_no_difference -> { ExamSession.count } do
          post api_v1_exam_sessions_path({ params: invalid_start_time})
        end

        assert_response :bad_request
        assert_includes response.parsed_body, "Start time is not a valid time to take this exam"
      end
    end
  end
end