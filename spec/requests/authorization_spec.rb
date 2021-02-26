require 'rails_helper'
include Rails.application.routes.url_helpers

resource 'Users' do
  let(:raw_post) { params.to_json }
  let(:email) { 'sample@example.com' }
  let(:user_password) { 'password' }

  before do
    @user = create(:user, email: email, password: user_password)
    header 'Content-Type', 'application/json'
    header 'Accept', 'application/json'
  end

  post '/auth/sign_in' do
    with_options scope: :user, required: true do
      parameter :email, 'User email'
      parameter :password, 'User password'
    end

    context 'when invalid params' do
      example 'Unsuccessful attempt to sign in', document: false do
        do_request({ email: 'some_email@example.com', password: 'some_password' })

        expect(json_response['errors']).to eq(["Invalid login credentials. Please try again."])
        expect(response_status).to eq(401)
      end
    end

    context 'when valid params' do
      example 'Sign in' do
        do_request({ email: @user.email, password: @user.password })

        expect(json_response['data']['email']).to eq(email)
        expect(response_headers['token-type']).to match(/Bearer/)
        expect(response_headers['access-token']).not_to be_empty
        expect(response_status).to eq 200
      end
    end
  end

  post '/auth' do
    with_options scope: :user do
      parameter :email, 'User email', required: true
      parameter :password, 'User password', required: true
      parameter :password_confirmation, 'User password confirmation', required: true
    end

    context 'when invalid params' do
      example 'Unsuccessful attempt to register', document: false do
        do_request({ email: '' })

        expect(response_status).to eq(422)
      end
    end

    context 'when valid params' do
      example 'Register new account' do
        do_request({ email: "newuser@example.com", password: user_password,
                     password_confirmation: user_password })

        expect(User.count).to eq(2)
        expect(json_response['data']['email']).to eq('newuser@example.com')
        expect(response_status).to eq 200
      end
    end
  end

  delete '/auth/sign_out' do
    example 'Sign out' do
      do_request(@user.create_new_auth_token)

      expect(response_status).to eq(200)
      expect(response_headers['access-token']).to eq(nil)
    end
  end
end
