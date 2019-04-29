# frozen_string_literal: true

class MaterialesProveedores < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_salary?(costo) && valid_salary?(minimo)
  end
end
