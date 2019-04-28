class DetalleHorarioDisponibleArea < ApplicationRecord
  def valid?(s)
    area && horario_disp
  end
end
