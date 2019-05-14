# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    Octopus.using(:TEMP) do
      @etl = Empleado.all.present?

      if current_user.user_type == 3
        @empleados_E = Empleado.all.where(sistema: 'E', wrong: 1)
        @tipos_empleado_E = TipoEmpleado.all.where(sistema: 'E', wrong: 1)
        @recursos_materiales_E = RecursoMaterial.all.where(sistema: 'E', wrong: 1)
        @tarjeta_E = TarjetasTEMP.all.where(sistema: 'E', wrong: 1)
        @estancia_E = EstanciaTEMP.all.where(sistema: 'E', wrong: 1)
        @areas_E = AreasTEMP.all.where(sistema: 'E', wrong: 1)
        @cajeros = CajeroTEMP.all.where(sistema: 'E', wrong: 1)
        @estancia_cajero = EstanciaCajero.all.where(sistema: 'E', wrong: 1)
        @pasillos = PasilloTEMP.all.where(sistema: 'E', wrong: 1)
        @sensores = SensorTEMP.all.where(sistema: 'E', wrong: 1)
        @descuentos = DescuentoTEMP.all.where(sistema: 'E', wrong: 1)
        @tipos_accidentes = TipoAccidenteTEMP.all.where(sistema: 'E', wrong: 1)
        @accidentes = AccidenteTEMP.all.where(sistema: 'E', wrong: 1)
        @proveedores_E = ProveedoresTEMP.all.where(sistema: 'E', wrong: 1)
        @tipos_materiales_E = TiposMaterialesTEMP.all.where(sistema: 'E', wrong: 1)
        @proveedores_materiales_E = ProveedoresMaterialesTEMP.all.where(sistema: 'E', wrong: 1)
        @solicitudes_compras_E = SolicitudCompraTEMP.all.where(sistema: 'E', wrong: 1)
        @orden_despacho_E = OrdenDespachoTEMP.all.where(sistema: 'E', wrong: 1)
        @orden_despacho_materiales_E = OrdenDespachoMaterialesTEMP.all.where(sistema: 'E', wrong: 1)
      elsif current_user.user_type == 4
        @empleados_M = Empleado.all.where(sistema: 'M', wrong: 1)
        @tipos_empleado_M = TipoEmpleado.all.where(sistema: 'M', wrong: 1)
        @recursos_materiales_M = RecursoMaterial.all.where(sistema: 'M', wrong: 1)
        @tipo_area = TipoAreaTEMP.all.where(sistema: 'M', wrong: 1)
        @areas_M = AreasTEMP.all.where(sistema: 'M', wrong: 1)
        @horarios_disp = HorariosDisponiblesTEMP.all.where(sistema: 'M', wrong: 1)
        @proveedores_M = ProveedoresTEMP.all.where(sistema: 'M', wrong: 1)
        @categorias = ProveedoresTEMP.all.where(sistema: 'M', wrong: 1)
        @tipos_materiales_M = TiposMaterialesTEMP.all.where(sistema: 'M', wrong: 1)
        @proveedores_materiales_M = ProveedoresMaterialesTEMP.all.where(sistema: 'M', wrong: 1)
        @solicitudes_compras_M = SolicitudCompraTEMP.all.where(sistema: 'M', wrong: 1)
        @servicios = ServiciosTEMP.all.where(sistema: 'M', wrong: 1)
        @servicios_materiales = ServiciosMaterialesTEMP.all.where(sistema: 'M', wrong: 1)
        @tareas = TareasTEMP.all.where(sistema: 'M', wrong: 1)
        @tareas_materiales = TareasMaterialesTEMP.all.where(sistema: 'M', wrong: 1)
        @secciones = SeccionesBodegaTEMP.all.where(sistema: 'M', wrong: 1)
        @horarios = HorariosTEMP.all.where(sistema: 'M', wrong: 1)
        @tipos_incidentes = TiposIncidentesTEMP.all.where(sistema: 'M', wrong: 1)
        @incidentes = IncidentesTEMP.all.where(sistema: 'M', wrong: 1)
        @ordenes_servicio = OrdenesServicioTEMP.all.where(sistema: 'M', wrong: 1)
        @contratistas = ContratistasTEMP.all.where(sistema: 'M', wrong: 1)
        @orden_servicio_contratistas = OrdenServicioContratistasTEMP.all.where(sistema: 'M', wrong: 1)
        @areas_servicios = AreasServiciosTEMP.all.where(sistema: 'M', wrong: 1)
        @orden_despacho_M = OrdenDespachoTEMP.all.where(sistema: 'M', wrong: 1)
        @orden_despacho_materiales_M = OrdenDespachoMaterialesTEMP.all.where(sistema: 'M', wrong: 1)
      elsif current_user.user_type == 2
        @empleados_F = Empleado.all.where(sistema: 'F', wrong: 1)
        @tipos_empleado_F = TipoEmpleado.all.where(sistema: 'F', wrong: 1)
        @locales = LocalTEMP.all.where(sistema: 'F', wrong: 1)
        @negocios = NegociosTEMP.all.where(sistema: 'F', wrong: 1)
        @negocios_locales = LocalNegocioTEMP.all.where(sistema: 'F', wrong: 1)
        @clientes = ClienteTEMP.all.where(sistema: 'F', wrong: 1)
        @contratos = ContratoTEMP.all.where(sistema: 'F', wrong: 1)
        @rentas = RentasTEMP.all.where(sistema: 'F', wrong: 1)
        @ganancias = GananciasTEMP.all.where(sistema: 'F', wrong: 1)
        @ingresos_estacionamiento = IngresoEstacionamientoTEMP.all.where(sistema: 'F', wrong: 1)
        @egresos_mantenimiento = EgresoMantenimientoTEMP.all.where(sistema: 'F', wrong: 1)
        @pagos = PagosTEMP.all.where(sistema: 'F', wrong: 1)
        @abonos = AbonosTEMP.all.where(sistema: 'F', wrong: 1)
      elsif @etl
        @no_more_errors = check_if_no_more_errors
      end
    end
  end

  private

  def check_if_no_more_errors
    Octopus.using(:TEMP) do
      TipoEmpleado.all.where(wrong: 1).empty? &&
      Empleado.all.where(wrong: 1).empty? &&
      TarjetasTEMP.all.where(wrong: 1).empty? &&
      EstanciaTEMP.all.where(wrong: 1).empty? &&
      TipoAreaTEMP.all.where(wrong: 1).empty? &&
      AreasTEMP.all.where(wrong: 1).empty? &&
      CajeroTEMP.all.where(wrong: 1).empty? &&
      EstanciaCajero.all.where(wrong: 1).empty? &&
      PasilloTEMP.all.where(wrong: 1).empty? &&
      SensorTEMP.all.where(wrong: 1).empty? &&
      HorariosDisponiblesTEMP.all.where(wrong: 1).empty? &&
      LocalTEMP.all.where(wrong: 1).empty? &&
      NegociosTEMP.all.where(wrong: 1).empty? &&
      LocalNegocioTEMP.all.where(wrong: 1).empty? &&
      DescuentoTEMP.all.where(wrong: 1).empty? &&
      TipoAccidenteTEMP.all.where(wrong: 1).empty? &&
      AccidenteTEMP.all.where(wrong: 1).empty? &&
      ClienteTEMP.all.where(wrong: 1).empty? &&
      ContratoTEMP.all.where(wrong: 1).empty? &&
      RentasTEMP.all.where(wrong: 1).empty? &&
      ProveedoresTEMP.all.where(wrong: 1).empty? &&
      CategoriasTEMP.all.where(wrong: 1).empty? &&
      TiposMaterialesTEMP.all.where(wrong: 1).empty? &&
      RecursoMaterial.all.where(wrong: 1).empty? &&
      ProveedoresMaterialesTEMP.all.where(wrong: 1).empty? &&
      SolicitudCompraTEMP.all.where(wrong: 1).empty? &&
      ServiciosTEMP.all.where(wrong: 1).empty? &&
      ServiciosMaterialesTEMP.all.where(wrong: 1).empty? &&
      TareasTEMP.all.where(wrong: 1).empty? &&
      TareasMaterialesTEMP.all.where(wrong: 1).empty? &&
      SeccionesBodegaTEMP.all.where(wrong: 1).empty? &&
      HorariosTEMP.all.where(wrong: 1).empty? &&
      TiposIncidentesTEMP.all.where(wrong: 1).empty? &&
      IncidentesTEMP.all.where(wrong: 1).empty? &&
      OrdenesServicioTEMP.all.where(wrong: 1).empty? &&
      OrdenServicioContratistasTEMP.all.where(wrong: 1).empty? &&
      AreasServiciosTEMP.all.where(wrong: 1).empty? &&
      OrdenDespachoTEMP.all.where(wrong: 1).empty? &&
      OrdenDespachoMaterialesTEMP.all.where(wrong: 1).empty? &&
      GananciasTEMP.all.where(wrong: 1).empty? &&
      PagosTEMP.all.where(wrong: 1).empty? &&
      AbonosTEMP.all.where(wrong: 1).empty?
    end
  end
end
