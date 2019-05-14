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
      redirect_to authenticated_root_path
    end
  end

  def delete_element
    Octopus.using(:TEMP) do
      sql = "DELETE FROM #{params[:table]} WHERE id = #{params[:id]}"
      ActiveRecord::Base.connection.execute(sql)
    end
    redirect_to authenticated_root_path
  end

  def delete_table
    Octopus.using(:TEMP) do
      sql = "DELETE FROM #{params[:table]} WHERE sistema = '#{params[:sistema]}' and wrong = 1;"
      ActiveRecord::Base.connection.execute(sql)
    end
    redirect_to authenticated_root_path
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

  def send_to_dtwh
    Octopus.using(:TEMP) do
      @empleados = Empleado.all.to_a
      @tipos_empleado = TipoEmpleado.all.to_a
      @recursos_materiales = RecursoMaterial.all.to_a
      @tarjeta = TarjetasTEMP.all.to_a
      @estancia = EstanciaTEMP.all.to_a
      @areas = AreasTEMP.all.to_a
      @cajeros = CajeroTEMP.all.to_a
      @estancia_cajero = EstanciaCajero.all.to_a
      @pasillos = PasilloTEMP.all.to_a
      @sensores = SensorTEMP.all.to_a
      @descuentos = DescuentoTEMP.all.to_a
      @tipos_accidentes = TipoAccidenteTEMP.all.to_a
      @accidentes = AccidenteTEMP.all.to_a
      @proveedores = ProveedoresTEMP.all.to_a
      @tipos_materiales = TiposMaterialesTEMP.all.to_a
      @proveedores_materiales = ProveedoresMaterialesTEMP.all.to_a
      @solicitudes_compras = SolicitudCompraTEMP.all.to_a
      @orden_despacho = OrdenDespachoTEMP.all.to_a
      @orden_despacho_materiales = OrdenDespachoMaterialesTEMP.all.to_a
      @tipo_area = TipoAreaTEMP.all.to_a
      @horarios_disp = HorariosDisponiblesTEMP.all.to_a
      @servicios = ServiciosTEMP.all.to_a
      @servicios_materiales = ServiciosMaterialesTEMP.all.to_a
      @tareas = TareasTEMP.all.to_a
      @tareas_materiales = TareasMaterialesTEMP.all.to_a
      @secciones = SeccionesBodegaTEMP.all.to_a
      @horarios = HorariosTEMP.all.to_a
      @tipos_incidentes = TiposIncidentesTEMP.all.to_a
      @incidentes = IncidentesTEMP.all.to_a
      @ordenes_servicio = OrdenesServicioTEMP.all.to_a
      @contratistas = ContratistasTEMP.all.to_a
      @orden_servicio_contratistas = OrdenServicioContratistasTEMP.all.to_a
      @areas_servicios = AreasServiciosTEMP.all.to_a
      @locales = LocalTEMP.all.to_a
      @negocios = NegociosTEMP.all.to_a
      @negocios_locales = LocalNegocioTEMP.all.to_a
      @clientes = ClienteTEMP.all.to_a
      @contratos = ContratoTEMP.all.to_a
      @rentas = RentasTEMP.all.to_a
      @ganancias = GananciasTEMP.all.to_a
      @ingresos_estacionamiento = IngresoEstacionamientoTEMP.all.to_a
      @egresos_mantenimiento = EgresoMantenimientoTEMP.all.to_a
      @pagos = PagosTEMP.all.to_a
      @abonos = AbonosTEMP.all.to_a

      Octopus.using(:DTWH) do
        @empleados.each { |e| Empleado.create(nombre: e.nombre, curp: e.curp, id_tipoempleado: e.id_tipoempleado, original_id: e.original_id, sistema: e.sistema) }

        @tipos_empleado.each { |te| TipoEmpleado.create(nombre: te.nombre, salario: te.salario, original_id: te.original_id, sistema: te.sistema) }

        @recursos_materiales.each { |rm| RecursoMaterial.create(nombre: rm.nombre, categoria: rm.categoria, tipo: rm.tipo, original_id: rm.original_id, sistema: rm.sistema) }

        @tarjeta.each { |t| TarjetasTEMP.create(estado: t.estado, original_id: t.original_id, sistema: t.sistema) }

        @estancia.each { |e| EstanciaTEMP.create(fechainicio: e.fechainicio, fechafin: e.fechafin, horainicio: e.horainicio, horafin: e.horafin, duracion: e.duracion, estado: e.estado, subtotal: e.subtotal, total: e.total, placa: e.placa, id_tarjeta: e.id_tarjeta, original_id: e.original_id, sistema: e.sistema) }

        @areas.each { |a| AreasTEMP.create(nombre: a.nombre, descripcion: a.descripcion, id_tipoarea: a.id_tipoarea, original_id: a.original_id, sistema: a.sistema) }

        @cajeros.each { |c| CajeroTEMP.create(dineroactual: c.dineroactual, fechaactual: c.fechaactual, periodicidadmantenimiento: c.periodicidadmantenimiento, estado: c.estado, id_area: c.id_area, original_id: c.original_id, sistema: c.sistema) }

        @estancia_cajero.each { |ec| EstanciaCajero.create(tarifa: ec.tarifa, fechainicio: ec.fechainicio, fechafin: ec.fechafin, id_estancia: ec.id_estancia, original_id: ec.original_id, sistema: ec.sistema) }

        @pasillos.each { |pa| PasilloTEMP.create(numero: pa.numero, cantidad_ocupados: pa.cantidad_ocupados, cantidad_libres: pa.cantidad_libres, id_area: pa.id_area, original_id: pa.original_id, sistema: pa.sistema) }

        @sensores.each { |s| SensorTEMP.create(estado: s.estado, fecha: s.fecha, id_pasillo: s.id_pasillo, original_id: s.original_id, sistema: s.sistema) }

        @descuentos.each { |d| DescuentoTEMP.create(cantidad: d.cantidad, id_negocio: d.id_negocio, id_estancia: d.id_estancia, original_id: d.original_id, sistema: d.sistema) }

        @tipos_accidentes.each { |ta| TipoAccidenteTEMP.create(nombre: ta.nombre, original_id: ta.original_id, sistema: ta.sistema) }

        @accidentes.each { |a| AccidenteTEMP.create(fecha: a.fecha, id_tipoaccidente: a.id_tipoaccidente, id_empleado: a.id_empleado, id_area: a.id_area, original_id: a.original_id, sistema: a.sistema) }

        @proveedores.each { |pr| ProveedoresTEMP.create(nombre: pr.nombre, rfc: pr.rfc, telefono: pr.telefono, direccion: pr.direccion, original_id: pr.original_id, sistema: pr.sistema) }

        @tipos_materiales.each { |tm| TiposMaterialesTEMP.create(nombre: tm.nombre, original_id: tm.original_id, sistema: tm.sistema) }

        @proveedores_materiales.each { |pm| ProveedoresMaterialesTEMP.create(costo: pm.costo, minimo: pm.minimo, id_recursomaterial: pm.id_recursomaterial, id_proveedor: pm.id_proveedor, original_id: pm.original_id, sistema: pm.sistema) }

        @solicitudes_compras.each { |sc| SolicitudCompraTEMP.create(cantidad_total: sc.cantidad_total, fechaemision: sc.fechaemision, costototal: sc.costototal, id_proveedor: sc.id_proveedor, id_empleado: sc.id_empleado, original_id: sc.original_id, sistema: sc.sistema) }

        @orden_despacho.each { |od| OrdenDespachoTEMP.create(fechaentrega: od.fechaentrega, id_solicitud: od.id_solicitud, original_id: od.original_id, sistema: od.sistema) }

        @orden_despacho_materiales.each { |odm| OrdenDespachoMaterialesTEMP.create(cantidadrecibida: odm.cantidadrecibida, fechadecaducidad: odm.fechadecaducidad, id_recursomaterial: odm.id_recursomaterial,id_ordendespacho: odm.id_ordendespacho, original_id: odm.original_id, sistema: odm.sistema) }

        @tipo_area.each { |ta| TipoAreaTEMP.create(nombre: ta.nombre, original_id: ta.original_id, sistema: ta.sistema) }

        @horarios_disp.each { |hd| HorariosDisponiblesTEMP.create(horainicio: hd.horainicio, horafin: hd.horafin, dia: hd.dia, original_id: hd.original_id, sistema: hd.sistema) }

        @servicios.each { |s| ServiciosTEMP.create(nombre: s.nombre, duracion: s.duracion, tipo_servicio: s.tipo_servicio, original_id: s.original_id, sistema: s.sistema) }

        @servicios_materiales.each { |sm| ServiciosMaterialesTEMP.create(cantidad: sm.cantidad, id_servicio: sm.id_servicio, recurso_material: sm.recurso_material, original_id: sm.original_id, sistema: sm.sistema) }

        @tareas.each { |t| TareasTEMP.create(duracion: t.duracion, id_servicio: t.id_servicio, id_area: t.id_area, original_id: t.original_id, sistema: t.sistema) }

        @tareas_materiales.each { |tm| TareasMaterialesTEMP.create(cantidadentregada: tm.cantidadentregada, id_tarea: tm.id_tarea, id_recursomaterial: tm.id_recursomaterial, id_empleado: tm.id_empleado, original_id: tm.original_id, sistema: tm.sistema) }

        @secciones.each { |s| SeccionesBodegaTEMP.create(nombre: s.nombre, tamaño: s.tamaño, estante: s.estante, numero: s.numero, id_recursomaterial: s.id_recursomaterial, original_id: s.original_id, sistema: s.sistema) }

        @horarios.each { |hor| HorariosTEMP.create(horainicio: hor.horainicio, horafin: hor.horafin, fechainicio: hor.fechainicio, fechafin: hor.fechafin, id_tarea: hor.id_tarea, id_empleado: hor.id_empleado, original_id: hor.original_id, sistema: hor.sistema) }

        @tipos_incidentes.each { |ti| TiposIncidentesTEMP.create(nombre: ti.nombre, descripcion: ti.descripcion, original_id: ti.original_id, sistema: ti.sistema) }

        @incidentes.each { |inci| IncidentesTEMP.create(fecha: inci.fecha, clavenotacredito: inci.clavenotacredito, clavenotadebito: inci.clavenotadebito, id_tipoincidente: inci.id_tipoincidente, id_empleado: inci.id_empleado, id_recurso_material: inci.id_recurso_material, original_id: inci.original_id, sistema: inci.sistema) }

        @ordenes_servicio.each { |os| OrdenesServicioTEMP.create(fecha: os.fecha, prioridad: os.prioridad, id_tarea: os.id_tarea, id_empleado: os.id_empleado, original_id: os.original_id, sistema: os.sistema) }

        @contratistas.each { |ct| ContratistasTEMP.create(nombre: ct.nombre, direccion: ct.direccion, numero: ct.numero, original_id: ct.original_id, sistema: ct.sistema) }

        @orden_servicio_contratistas.each { |ct| OrdenServicioContratistasTEMP.create(costo: ct.costo, tiempo: ct.tiempo, id_ordenservicio: ct.id_ordenservicio, id_contratante: ct.id_contratante, original_id: ct.original_id, sistema: ct.sistema) }

        @areas_servicios.each { |asv| AreasServiciosTEMP.create(periodicidad: asv.periodicidad, id_servicio: asv.id_servicio, id_tipoarea: asv.id_tipoarea, original_id: asv.original_id, sistema: asv.sistema) }

        @locales.each { |l| LocalTEMP.create(numero: l.numero, ubicacion: l.ubicacion, dimensiones: l.dimensiones, estado: l.estado, costo: l.costo, original_id: l.original_id, sistema: l.sistema) }

        @negocios.each { |ng| NegociosTEMP.create(nombre: ng.nombre, giro: ng.giro, estado: ng.estado, id_locales: ng.id_locales, original_id: ng.original_id, sistema: ng.sistema) }

        @negocios_locales.each { |nl| LocalNegocioTEMP.create(fechainicio: nl.fechainicio, fechafin: nl.fechafin, id_negocio: nl.id_negocio, id_locales: nl.id_locales, original_id: nl.original_id, sistema: nl.sistema) }

        @clientes.each { |cl| ClienteTEMP.create(nombre: cl.nombre, RFC: cl.RFC, original_id: cl.original_id, sistema: cl.sistema) }

        @contratos.each { |ctr| ContratoTEMP.create(fechainicio: ctr.fechainicio, fechafin: ctr.fechafin, costo: ctr.costo, id_cliente: ctr.id_cliente, id_local: ctr.id_local, original_id: ctr.original_id, sistema: ctr.sistema) }

        @rentas.each { |rent| RentasTEMP.create(fechacobro: rent.fechacobro, statusretraso: rent.statusretraso, statuspagado: rent.statuspagado, id_contrato: rent.id_contrato, original_id: rent.original_id, sistema: rent.sistema) }

        @ganancias.each { |gn| GananciasTEMP.create(ingresos: gn.ingresos, egresos: gn.egresos, fechacorte: gn.fechacorte, original_id: gn.original_id, sistema: gn.sistema) }

        @ingresos_estacionamiento.each { |iest| IngresoEstacionamientoTEMP.create(cantidad: iest.cantidad, fecha: iest.fecha, id_ganacia: iest.id_ganacia, original_id: iest.original_id, sistema: iest.sistema) }

        @egresos_mantenimiento.each { |eest| EgresoMantenimientoTEMP.create(cantidad: eest.cantidad, fecha: eest.fecha, id_ganancia: eest.id_ganancia, original_id: eest.original_id, sistema: eest.sistema) }

        @pagos.each { |pag| PagosTEMP.create(fecha: pag.fecha, monto: pag.monto, id_empleado: pag.id_empleado, id_ganancia: pag.id_ganancia, original_id: pag.original_id, sistema: pag.sistema) }

        @abonos.each { |abon| AbonosTEMP.create(fechapago: abon.fechapago, saldorestante: abon.saldorestante, monto: abon.monto, id_renta: abon.id_renta, id_ganancia: abon.id_ganancia, original_id: abon.original_id, sistema: abon.sistema) }
      end
    end
    redirect_to authenticated_root_path
  end


  def update
    Octopus.using(:TEMP) do
      UpdateTemp.update_object(params)
    end
    redirect_to authenticated_root_path
  end
end
