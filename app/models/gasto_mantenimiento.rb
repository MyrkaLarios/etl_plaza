# frozen_string_literal: true

class GastoMantenimiento < ApplicationRecord
  self.table_name = 'GastoMantenimiento'
  include ValidationsHelper

  def valid?(s)
    valid_number?(cantidad) && valid_date?(fecha)
  end
end
