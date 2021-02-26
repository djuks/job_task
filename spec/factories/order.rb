# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    name { 'order name' }
    user
  end
end
