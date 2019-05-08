# frozen_string_literal: true

class DetalleProveedoresEquipos < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_salary?(costo_Menudeo)
  end
end
