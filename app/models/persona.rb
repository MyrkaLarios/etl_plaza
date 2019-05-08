# frozen_string_literal: true

class Persona < ApplicationRecord
  include ValidationsHelper
  def valid?(s)
    valid_name?(nombre) && valid_CURP?(curp)
  end
end
