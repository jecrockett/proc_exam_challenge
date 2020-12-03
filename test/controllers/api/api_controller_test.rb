require 'test_helper'

class Api::ApiControllerTest < ActionDispatch::IntegrationTest
  describe 'request logging' do
    before do
      Rails.application.routes.draw do
        get '/test_api_controller' => 'fake_api#index'
      end
    end

    after do
      Rails.application.reload_routes!
    end

    it 'logs requests and responses for controllers that inherit from ApiController' do
      assert_difference -> { ApiRequest.count } do
        get '/test_api_controller'
      end

      logged_request = ApiRequest.last
      json_payload = { controller: 'fake_api', action: 'index'}.to_json

      assert_equal 'GET', logged_request.request_method
      assert_equal '/test_api_controller', logged_request.endpoint
      assert_equal json_payload, logged_request.payload
      assert_equal '200', logged_request.response_code
      assert_equal 'thanks for the request', logged_request.response_body
    end
  end
end

# Temporary fake controller for testing purposes
class FakeApiController < Api::ApiController
  def index
    render json: 'thanks for the request'
  end
end
