# frozen_string_literal: true

module ApiHelpers
  def json_response
    @json_response ||= JSON.parse(response_body)
  end

  def login_user(user)
    headers = user.create_new_auth_token

    header 'Content-Type', 'application/json'
    header 'Accept', 'application/json'
    header "access-token", headers["access-token"]
    header "token-type", headers["token-type"]
    header "client", headers["client"]
    header "expiry", headers["expiry"]
    header "uid", headers["uid"]
  end
end
