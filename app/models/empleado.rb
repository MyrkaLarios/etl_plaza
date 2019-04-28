# frozen_string_literal: true

class Empleado < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    c = self[:CURP] ? self[:CURP] : self[:curp]
    valid_name?(nombre) && valid_CURP?(c)
  end
end
