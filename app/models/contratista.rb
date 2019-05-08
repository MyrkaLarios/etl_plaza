# frozen_string_literal: true

class Contratista < ApplicationRecord
  self.table_name = 'contratistas'
  include ValidationsHelper

  def valid?(s)
    valid_telefono?(numero) && valid_business_name?(nombre)
  end
end
