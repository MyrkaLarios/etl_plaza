class EtlController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    actual_etl = false
    Octopus.using(:TEMP) do
      actual_etl = Empleado.all.present?
    end
    if actual_etl
      Octopus.using(:TEMP) do
        @empleados = Empleado.all.where(wrong: 1)
        @tipos_empleado = TipoEmpleado.all.where(wrong: 1)
        @recursos_materiales = RecursoMaterial.all.where(wrong: 1)
        @tarjeta = TarjetasTEMP.all.where(wrong: 1)
        @estancia = EstanciaTEMP.all.where(wrong: 1)
        @areas = AreasTEMP.all.where(wrong: 1)
        @cajeros = CajeroTEMP.all.where(wrong: 1)
        @estancia_cajero = EstanciaCajero.all.where(wrong: 1)
        @pasillos = PasilloTEMP.all.where(wrong: 1)
        @sensores = SensorTEMP.all.where(wrong: 1)
        @descuentos = DescuentoTEMP.all.where(wrong: 1)
        @tipos_accidentes = TipoAccidenteTEMP.all.where(wrong: 1)
        @accidentes = AccidenteTEMP.all.where(wrong: 1)
        @proveedores = ProveedoresTEMP.all.where(wrong: 1)
        @tipos_materiales = TiposMaterialesTEMP.all.where(wrong: 1)
        @proveedores_materiales = ProveedoresMaterialesTEMP.all.where(wrong: 1)
        @solicitudes_compras = SolicitudCompraTEMP.all.where(wrong: 1)
        @orden_despacho = OrdenDespachoTEMP.all.where(wrong: 1)
        @orden_despacho_materiales = OrdenDespachoMaterialesTEMP.all.where(wrong: 1)
        @tipo_area = TipoAreaTEMP.all.where(wrong: 1)
        @horarios_disp = HorariosDisponiblesTEMP.all.where(wrong: 1)
        @servicios = ServiciosTEMP.all.where(wrong: 1)
        @servicios_materiales = ServiciosMaterialesTEMP.all.where(wrong: 1)
        @tareas = TareasTEMP.all.where(wrong: 1)
        @tareas_materiales = TareasMaterialesTEMP.all.where(wrong: 1)
        @secciones = SeccionesBodegaTEMP.all.where(wrong: 1)
        @horarios = HorariosTEMP.all.where(wrong: 1)
        @tipos_incidentes = TiposIncidentesTEMP.all.where(wrong: 1)
        @incidentes = IncidentesTEMP.all.where(wrong: 1)
        @ordenes_servicio = OrdenesServicioTEMP.all.where(wrong: 1)
        @contratistas = ContratistasTEMP.all.where(wrong: 1)
        @orden_servicio_contratistas = OrdenServicioContratistasTEMP.all.where(wrong: 1)
        @areas_servicios = AreasServiciosTEMP.all.where(wrong: 1)
        @locales = LocalTEMP.all.where(wrong: 1)
        @negocios = NegociosTEMP.all.where(wrong: 1)
        @negocios_locales = LocalNegocioTEMP.all.where(wrong: 1)
        @clientes = ClienteTEMP.all.where(wrong: 1)
        @contratos = ContratoTEMP.all.where(wrong: 1)
        @rentas = RentasTEMP.all.where(wrong: 1)
        @ganancias = GananciasTEMP.all.where(wrong: 1)
        @ingresos_estacionamiento = IngresoEstacionamientoTEMP.all.where(wrong: 1)
        @egresos_mantenimiento = EgresoMantenimientoTEMP.all.where(wrong: 1)
        @pagos = PagosTEMP.all.where(wrong: 1)
        @abonos = AbonosTEMP.all.where(wrong: 1)
      end
    else
      Etl.start
      redirect_to etl_index_path
    end
  end

  def delete_element
    Octopus.using(:TEMP) do
      sql = "DELETE FROM #{params[:table]} WHERE id = #{params[:id]}"
      ActiveRecord::Base.connection.execute(sql)
    end
    if current_user.user_type == 1
      redirect_to etl_index_path
    else
      redirect_to authenticated_root_path
    end
  end

  def modify_element
    @table = params[:table]
    @system = params[:s]
    @id = params[:id]
    Octopus.using(:TEMP) do
      case @table
      when 'dbo.EMPLEADOS'
        @element = Empleado.find(@id)
      when 'dbo.TIPO_EMPLEADOS'
        @element = TipoEmpleado.find(@id)
      when 'dbo.RECURSO_MATERIAL'
        @element = RecursoMaterial.find(@id)
      when 'dbo.TARJETA'
        @element = TarjetasTEMP.find(@id)
      when 'dbo.ESTANCIA'
        @element = EstanciaTEMP.find(@id)
      when 'dbo.TIPO_AREA'
        @element = TipoAreaTEMP.find(@id)
      when 'dbo.AREA'
        @element = AreasTEMP.find(@id)
      when 'dbo.CAJERO'
        @element = CajeroTEMP.find(@id)
      when 'dbo.ESTANCIA_CAJERO'
        @element = EstanciaCajero.find(@id)
      when 'dbo.PASILLO'
        @element = PasilloTEMP.find(@id)
      when 'dbo.SENSOR'
        @element = SensorTEMP.find(@id)
      when 'dbo.HORARIO_DISPONIBLE'
        @element = HorariosDisponiblesTEMP.find(@id)
      when 'dbo.LOCALES'
        @element = LocalTEMP.find(@id)
      when 'dbo.NEGOCIOS'
        @element = NegociosTEMP.find(@id)
      when 'dbo.LOCAL_NEGOCIO'
        @element = LocalNegocioTEMP.find(@id)
      when 'dbo.DESCUENTO'
        @element = DescuentoTEMP.find(@id)
      when 'dbo.TIPO_ACCIDENTE'
        @element = TipoAccidenteTEMP.find(@id)
      when 'dbo.ACCIDENTES'
        @element = AccidenteTEMP.find(@id)
      when 'dbo.CONTRATO'
        @element = ContratoTEMP.find(@id)
      when 'dbo.RENTAS'
        @element = RentasTEMP.find(@id)
      when 'dbo.PROVEEDOR'
        @element = ProveedoresTEMP.find(@id)
      when 'dbo.CATEGORIA'
        @element = CategoriasTEMP.find(@id)
      when 'dbo.TIPO_MATERIAL'
        @element = TiposMaterialesTEMP.find(@id)
      when 'dbo.PROVEEDOR_MATERIAL'
        @element = ProveedoresMaterialesTEMP.find(@id)
      when 'dbo.SOLICITUD_COMPRA'
        @element = SolicitudCompraTEMP.find(@id)
      when 'dbo.SERVICIO'
        @element = ServiciosTEMP.find(@id)
      when 'dbo.SERVICIO_MATERIAL'
        @element = ServiciosMaterialesTEMP.find(@id)
      when 'dbo.TAREA'
        @element = TareasTEMP.find(@id)
      when 'dbo.TAREA_MATERIAL'
        @element = TareasMaterialesTEMP.find(@id)
      when 'dbo.SECCION_BODEGA'
        @element = SeccionesBodegaTEMP.find(@id)
      when 'dbo.HORARIO'
        @element = HorariosTEMP.find(@id)
      when 'dbo.TIPO_INCIDENTE'
        @element = TiposIncidentesTEMP.find(@id)
      when 'dbo.INCIDENTE'
        @element = IncidentesTEMP.find(@id)
      when 'dbo.ORDEN_SERVICIO'
        @element = OrdenesServicioTEMP.find(@id)
      when 'dbo.CONTRATANTE'
        @element = ContratistasTEMP.find(@id)
      when 'dbo.ORDENSERVICIO_CONTRATANTE'
        @element = OrdenServicioContratistasTEMP.find(@id)
      when 'dbo.AREA_SERVICIO'
        @element = AreasServiciosTEMP.find(@id)
      when 'dbo.ORDEN_DESPACHO'
        @element = OrdenDespachoTEMP.find(@id)
      when 'dbo.ORDENDESPACHO_MATERIAL'
        @element = OrdenDespachoMaterialesTEMP.find(@id)
      when 'dbo.GANANCIAS'
        @element = GananciasTEMP.find(@id)
      when 'dbo.INGRESO_ESTACIONAMIENTO'
        @element = IngresoEstacionamientoTEMP.find(@id)
      when 'dbo.EGRESO_MANTENIMIENTO'
        @element = EgresoMantenimientoTEMP.find(@id)
      when 'dbo.PAGOS'
        @element = PagosTEMP.find(@id)
      when 'dbo.ABONOS'
        @element = AbonosTEMP.find(@id)
      end
    end
  end


  def update
    Octopus.using(:TEMP) do
      UpdateTemp.update_object(params)
    end
    if current_user.user_type == 1
      redirect_to etl_index_path
    else
      redirect_to authenticated_root_path
    end
  end
end
