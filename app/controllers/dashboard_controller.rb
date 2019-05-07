# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    Octopus.using(:TEMP) do
      @etl = Empleado.all.present?
      @empleados_E = Empleado.all.where(sistema: 'E', wrong: 1)
      @tipos_empleado_E = TipoEmpleado.all.where(sistema: 'E', wrong: 1)
      @recursos_materiales_E = RecursoMaterial.all.where(sistema: 'E', wrong: 1)
      @tarjeta_E = TarjetasTEMP.all.where(sistema: 'E', wrong: 1)
      @estancia_E = EstanciaTEMP.all.where(sistema: 'E', wrong: 1)
      @areas_E = AreasTEMP.all.where(sistema: 'E', wrong: 1)
      @cajeros = CajeroTEMP.all.where(sistema: 'E', wrong: 1)

      @empleados_M = Empleado.all.where(sistema: 'M', wrong: 1)
      @tipos_empleado_M = TipoEmpleado.all.where(sistema: 'M', wrong: 1)
      @recursos_materiales_M = RecursoMaterial.all.where(sistema: 'M', wrong: 1)
      @tipo_area = TipoAreaTEMP.all.where(sistema: 'M', wrong: 1)
      @areas_M = AreasTEMP.all.where(sistema: 'M', wrong: 1)

      @empleados_F = Empleado.all.where(sistema: 'F', wrong: 1)
      @tipos_empleado_F = TipoEmpleado.all.where(sistema: 'F', wrong: 1)
    end
  end
end
