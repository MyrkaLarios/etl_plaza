class TipoEmpleado < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_name?(nombre) && valid_salary?(salario)
  end
end
