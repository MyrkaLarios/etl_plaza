# frozen_string_literal: true

class Supervisiones < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    true
  end
end
