class TipoEmpleado < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    case s
    when 'E'
      valid_name?(nombre)
    when 'F'
      valid_name?(nombre)
      valid_salary?(salario)
    end
  end
end
