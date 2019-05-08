# frozen_string_literal: true

class EmpleadoEstacionamiento < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_name?(nombre) && valid_CURP?(curp)
  end
end
