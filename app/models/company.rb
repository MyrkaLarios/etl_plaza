# frozen_string_literal: true
# == Schema Information
#
# Table name: companies
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  database_id :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Company < ApplicationRecord
  has_one :database

  validates :name, uniqueness: true
end
