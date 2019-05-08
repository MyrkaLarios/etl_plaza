# frozen_string_literal: true

class TiposAccidente < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_name?(nombre)
  end
end
