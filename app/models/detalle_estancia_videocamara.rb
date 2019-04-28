class DetalleEstanciaVideocamara < ApplicationRecord
  include ValidationsHelper
  def valid?(s)
    valid_placa?(placa)
  end
end
