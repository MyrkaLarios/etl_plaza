# frozen_string_literal: true

class Empleado < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    case s
    when 'E'
      valid_name?(nombre) &&
      valid_CURP?(curp)
    when 'F'
      valid_name?(nombre) &&
      valid_CURP?(self.CURP)
    end
  end
end
