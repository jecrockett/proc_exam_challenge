require 'test_helper'

class ApiRequestTest < ActiveSupport::TestCase
  describe 'ApiRequest' do
    let(:api_request) do
      build(:api_request,
        request_method: "200",
        endpoint: "/test_endpoint",
        payload: "{\"attribute\"=>\"value\", \"other_attribute\"=>\"other_value\"}",
        remote_ip: "::1",
        response_code: "200",
        response_body: "you got it dude",
        error_message: nil,
      )
    end

    it 'is valid with all attributes' do
      assert api_request.valid?
    end

    it 'is valid with an error' do
      api_request.response_code = nil
      api_request.response_body = nil
      api_request.error_message = 'StandardError'

      assert api_request.valid?
    end
  end
end
