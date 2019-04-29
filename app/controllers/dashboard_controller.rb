# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @etl = Empleado.all.present?
    Octopus.using(:TEMP) do
      @empleados_E = Empleado.all.where(sistema: 'E')
      @tipos_empleado_E = TipoEmpleado.all.where(sistema: 'E')
      @tarjeta_E = TarjetasTEMP.all

      @empleados_M = Empleado.all.where(sistema: 'M')
      @tipos_empleado_M = TipoEmpleado.all.where(sistema: 'M')

      @empleados_F = Empleado.all.where(sistema: 'F')
      @tipos_empleado_F = TipoEmpleado.all.where(sistema: 'F')
    end
  end
end
