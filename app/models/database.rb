# frozen_string_literal: true

# == Schema Information
#
# Table name: databases
#
#  id         :bigint(8)        not null, primary key
#  host       :string
#  adapter    :string
#  mode       :string
#  port       :string
#  password   :string
#  username   :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Database < ApplicationRecord
  # belongs_to :company
end
