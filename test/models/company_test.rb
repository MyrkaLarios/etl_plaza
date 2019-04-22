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

require "test_helper"

describe Company do
  let(:company) { Company.new }

  it "must be valid" do
    value(company).must_be :valid?
  end
end
