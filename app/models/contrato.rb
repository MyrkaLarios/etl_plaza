# frozen_string_literal: true

class Contrato < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_date?(fechainicio.to_date) && valid_business_date?(fechafin.to_date) && valid_salary?(costo.to_i)
  end
end
