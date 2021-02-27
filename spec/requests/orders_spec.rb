require 'rails_helper'
include Rails.application.routes.url_helpers

resource 'Orders' do
  let(:raw_post) { params.to_json }

  before do
    @user = create(:user)
    @orders = create_list(:order, 2, user: @user)

    login_user(@user)
  end

  get '/orders' do
    let(:user_id) { @user.id }

    parameter :user_id, 'User id', required: true

    example 'Get all user orders' do
      do_request

      expect(json_response['data'].count).to eq(2)
      expect(json_response['data'].first['id']).to eq(@orders.first.id.to_s)
      expect(json_response['data'].first['relationships']['user']['data']['id']).to eq(@user.id.to_s)
      expect(response_status).to eq(200)
    end
  end

  get '/orders/:id' do
    let(:id) { @orders.first.id }

    example 'Show one user order' do
      do_request

      expect(json_response['data']['id']).to eq(@orders.first.id.to_s)
      expect(json_response['data']['relationships']['user']['data']['id']).to eq(@user.id.to_s)
      expect(response_status).to eq(200)
    end
  end

  post '/orders' do
    let(:name) { "sample_order" }

    with_options scope: :order do
      parameter :name, 'Order name', required: true
    end

    context 'When valid params' do
      example 'Create user order' do
        expect(Order.count).to eq(2)

        do_request

        expect(Order.count).to eq(3)
        expect(json_response['data']['relationships']['user']['data']['id']).to eq(@user.id.to_s)
        expect(response_status).to eq(200)
      end
    end

    context 'when invalid params' do
      example 'raise error', document: false do
        expect { do_request({ order: { name: '' } }) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
