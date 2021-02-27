# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  respond_to :json

  def render_json(object, serializer, options = {})
    render json: serializer.constantize.new(object, options).serializable_hash
  end
end
