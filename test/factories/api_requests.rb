FactoryBot.define do
  factory :api_request do
    request_method { "200" }
    endpoint { "/test_endpoint" }
    payload { "{\"attribute\"=>\"value\", \"other_attribute\"=>\"other_value\"}" }
    remote_ip { "::1" }
    response_code { "200" }
    response_body { "you got it dude" }
  end
end
