# frozen_string_literal: true

class Pagos < ApplicationRecord
  self.table_name = 'Pagos'
  include ValidationsHelper

  def valid?(s)
    valid_number?(monto)
  end
end
