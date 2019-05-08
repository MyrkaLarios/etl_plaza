# frozen_string_literal: true

class Abonos < ApplicationRecord
  self.table_name = 'Abonos'
  include ValidationsHelper

  def valid?(s)
    valid_number?(monto) && valid_date?(fechacobro)
  end
end
