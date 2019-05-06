# frozen_string_literal: true

class OrdenesServicioPersonas < ApplicationRecord
  self.table_name = 'ordenes_servicios_personas'
  include ValidationsHelper

  def valid?(s)
    true
  end
end
