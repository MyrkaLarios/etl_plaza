# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    Octopus.using(:TEMP) do
      @etl = Empleado.all.present?
      @empleados_E = Empleado.all.where(sistema: 'E', wrong: 1)
      @tipos_empleado_E = TipoEmpleado.all.where(sistema: 'E', wrong: 1)
      @recursos_materiales_E = RecursoMaterial.all.where(sistema: 'E', wrong: 1)
      # @tarjeta_E = TarjetasTEMP.all

      @empleados_M = Empleado.all.where(sistema: 'M', wrong: 1)
      @tipos_empleado_M = TipoEmpleado.all.where(sistema: 'M', wrong: 1)
      @recursos_materiales_M = RecursoMaterial.all.where(sistema: 'M', wrong: 1)

      @empleados_F = Empleado.all.where(sistema: 'F', wrong: 1)
      @tipos_empleado_F = TipoEmpleado.all.where(sistema: 'F', wrong: 1)
    end
  end
end
