# frozen_string_literal: true

class AddRolesToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role, :integer, null: false, default: 1
  end
end
