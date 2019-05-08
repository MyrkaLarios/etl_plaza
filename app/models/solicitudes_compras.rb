# frozen_string_literal: true

class SolicitudesCompras < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_salary?(cantidad_Total) && valid_salary?(costo_Total)
  end
end
