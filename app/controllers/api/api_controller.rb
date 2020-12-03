class Api::ApiController < ApplicationController
  after_action :log_request

  private

  def log_request
    ApiRequest.create(
      request_method: request.method,
      endpoint: request.fullpath,
      payload: request.params.to_json,
      remote_ip: request.remote_ip,
      response_code: response.code,
      response_body: response.body,
    )
  end
end