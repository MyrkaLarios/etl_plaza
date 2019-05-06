# frozen_string_literal: true

class SeccionesBodega < ApplicationRecord
  include ValidationsHelper

  self.table_name = 'secciones_bodega'
  def valid?(s)
    true
  end
end
