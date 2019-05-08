class UpdateTemp

  def self.update_object(params)
    case params[:table]
    when 'dbo.EMPLEADOS'
      Empleado.update_obj(params)
    when 'dbo.TIPO_EMPLEADOS'
      TipoEmpleado.update_obj(params)
    when 'dbo.RECURSO_MATERIAL'
      RecursoMaterial.update_obj(params)
    when 'dbo.TARJETA'
      TarjetasTEMP.update_obj(params)
    when 'dbo.ESTANCIA'
      EstanciaTEMP.update_obj(params)
    when 'dbo.TIPO_AREA'
      TipoAreaTEMP.update_obj(params)
    when 'dbo.AREA'
      AreasTEMP.update_obj(params)
    when 'dbo.CAJERO'
      CajeroTEMP.update_obj(params)
    when 'dbo.ESTANCIA_CAJERO'
      EstanciaCajero.update_obj(params)
    when 'dbo.PASILLO'
      PasilloTEMP.update_obj(params)
    when 'dbo.SENSOR'
      SensorTEMP.update_obj(params)
    when 'dbo.HORARIO_DISPONIBLE'
      HorariosDisponiblesTEMP.update_obj(params)
    when 'dbo.LOCALES'
      LocalTEMP.update_obj(params)
    when 'dbo.NEGOCIOS'
      NegociosTEMP.update_obj(params)
    when 'dbo.LOCAL_NEGOCIO'
      LocalNegocioTEMP.update_obj(params)
    when 'dbo.DESCUENTO'
      DescuentoTEMP.update_obj(params)
    when 'dbo.TIPO_ACCIDENTE'
      TipoAccidenteTEMP.update_obj(params)
    when 'dbo.ACCIDENTES'
      AccidenteTEMP.update_obj(params)
    when 'dbo.CLIENTE'
      ClienteTEMP.update_obj(params)
    when 'dbo.CONTRATO'
      ContratoTEMP.update_obj(params)
    when 'dbo.RENTAS'
      RentasTEMP.update_obj(params)
    when 'dbo.PROVEEDOR'
      ProveedoresTEMP.update_obj(params)
    when 'dbo.CATEGORIA'
      CategoriasTEMP.update_obj(params)
    when 'dbo.TIPO_MATERIAL'
      TiposMaterialesTEMP.update_obj(params)
    when 'dbo.PROVEEDOR_MATERIAL'
      ProveedoresMaterialesTEMP.update_obj(params)
    when 'dbo.SOLICITUD_COMPRA'
      SolicitudCompraTEMP.update_obj(params)
    when 'dbo.SERVICIO'
      ServiciosTEMP.update_obj(params)
    when 'dbo.SERVICIO_MATERIAL'
      ServiciosMaterialesTEMP.update_obj(params)
    when 'dbo.TAREA'
      TareasTEMP.update_obj(params)
    when 'dbo.TAREA_MATERIAL'
      TareasMaterialesTEMP.update_obj(params)
    when 'dbo.SECCION_BODEGA'
      SeccionesBodegaTEMP.update_obj(params)
    when 'dbo.HORARIO'
      HorariosTEMP.update_obj(params)
    when 'dbo.TIPO_INCIDENTE'
      TiposIncidentesTEMP.update_obj(params)
    when 'dbo.INCIDENTE'
      IncidentesTEMP.update_obj(params)
    when 'dbo.ORDEN_SERVICIO'
      OrdenesServicioTEMP.update_obj(params)
    when 'dbo.CONTRATANTE'
      ContratistasTEMP.update_obj(params)
    when 'dbo.ORDENSERVICIO_CONTRATANTE'
      OrdenServicioContratistasTEMP.update_obj(params)
    when 'dbo.AREA_SERVICIO'
      AreasServiciosTEMP.update_obj(params)
    when 'dbo.ORDEN_DESPACHO'
      OrdenDespachoTEMP.update_obj(params)
    when 'dbo.ORDENDESPACHO_MATERIAL'
      OrdenDespachoMaterialesTEMP.update_obj(params)
    when 'dbo.GANANCIAS'
      GananciasTEMP.update_obj(params)
    when 'dbo.INGRESO_ESTACIONAMIENTO'
      IngresoEstacionamientoTEMP.update_obj(params)
    when 'dbo.EGRESO_MANTENIMIENTO'
      EgresoMantenimientoTEMP.update_obj(params)
    when 'dbo.PAGOS'
      PagosTEMP.update_obj(params)
    when 'dbo.ABONOS'
      AbonosTEMP.update_obj(params)
    end
    check_if_no_more_wrongs
  end

  def self.check_if_no_more_wrongs
    Empleado.where(wrong: 1).present?
  end

  #Cuando hagas el update
  def self.send_to_DWH(objects, s)
    ##debe venir el objeto y si ya es correcto se debe enviar a un metodo que en lugar de insertar actualice los datos
    ## debe llamar a un metodo que revise si ya ninguna tabla tiene registros equivocados
   end
end
