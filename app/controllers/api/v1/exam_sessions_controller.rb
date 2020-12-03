class Api::V1::ExamSessionsController < ApplicationController
  before_action :initialize_exam_session, :set_exam_and_check_college, :set_user, only: [:create]

  # POST /exam_sessions
  def create
    @exam_session.exam, @exam_session.user = @exam, @user

    if @exam_session.errors.none? && @exam_session.save
      head :ok
    else
      render json: @exam_session.errors.full_messages, status: :bad_request
    end
  end

  private

  def exam_session_params
    params.permit(
      :start_time
    )
  end

  def initialize_exam_session
    @exam_session = ExamSession.new(exam_session_params)
  end

  def normalized_phone_number
    Phonelib.parse(params[:phone_number]).full_e164.presence
  end

  def set_exam_and_check_college
    college = College.find_by(id: params[:college_id])
    @exam = Exam.find_by(id: params[:exam_id], college_id: college&.id)

    if college.nil?
      @exam_session.errors.add(:base, 'The provided college_id is not found')
    elsif @exam.nil?
      @exam_session.errors.add(:base, 'The requested exam is not found or not offered by the provided college')
    end
  end

  def set_user
    @user = User.find_or_create_by(user_params)
    @exam_session.errors.merge!(@user.errors) if @user.invalid?
  end

  def user_params
    params
      .permit(:phone_number, :first_name, :last_name)
      .merge({ phone_number: normalized_phone_number })
  end
end