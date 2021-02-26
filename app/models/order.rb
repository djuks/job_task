# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
end
