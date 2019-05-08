class Cajero < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_salary?(dinero_Actual) &&
    valid_date?(fecha_Instalacion) &&
    valid_estado_cajero?(estado) &&
    valid_periodicidad?(periodicidad_Mantenimiento)
  end
end
