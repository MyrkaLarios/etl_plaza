class HorarioDisponible < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_dia?(dia)
  end
end
