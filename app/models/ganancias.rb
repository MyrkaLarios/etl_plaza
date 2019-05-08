# frozen_string_literal: true

class Ganancias < ApplicationRecord
  self.table_name = 'GANANCIAS'
  include ValidationsHelper

  def valid?(s)
    valid_number?(cantidad)
  end
end
