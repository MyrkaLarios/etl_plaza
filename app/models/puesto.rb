# frozen_string_literal: true

class Puesto < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_name?(nombre)
  end
end
