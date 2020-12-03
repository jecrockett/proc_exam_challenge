class Api::ApiController < ApplicationController
  rescue_from StandardError, with: :log_error
  after_action :log_request

  private

  def log_request
    ApiRequest.create(
      **request_attrs,
      **response_attrs
    )
  end

  def log_error(error)
    ApiRequest.create(
      **request_attrs,
      error_message: error.message,
    )
  end

  private

  def request_attrs
    {
      request_method: request.method,
      endpoint: request.fullpath,
      payload: request.params.to_json,
      remote_ip: request.remote_ip,
    }
  end

  def response_attrs
    {
      response_code: response.code,
      response_body: response.body,
    }
  end
end