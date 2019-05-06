class TipoEmpleadoEstacionamiento < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    false #porque no tiene salario
  end
end
