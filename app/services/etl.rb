class Etl
  def self.start
    @new = true
    extract_employee_type_data
    extract_employee_data
    extract_tarjet_data
    extract_estancia_data
    extract_tipo_area_data
    extract_area_data
    extract_cajero_data
    extract_cajero_estancia
    extract_pasillo
    extract_sensor
    extract_horario_disp
    extract_horario_disp_detalle
    extract_locale
    extract_negocio
    extract_local_negocio
    extract_descuento
    extract_tipo_accidente
    extract_accidente
    extract_cliente
    extract_contrato
    extract_rentas
    extract_proveedores
    extract_categorias
    extract_material_types
    extract_materials
    extract_proveedor_material
    extract_solicitud_compra
    extract_servicios
    extract_servicios_materiales
    extract_tareas
    extract_tareas_materiales
    extract_bodega
    extract_horarios
    extract_supervisiones
    extract_tipo_incidente
    extract_incidentes
    extract_ordenes_servicio
    extract_ordenes_servicio_personas
    extract_contratistas
    extract_contratistas_servicios
    extract_areas_servicios
    extract_orden_despacho
    extract_orden_despacho_materiales
    extract_ganancias
  end

  def self.extract_employee_type_data
    Octopus.using(:E) do
      send_to_DWH_TEMP(TipoEmpleadoEstacionamiento.all, 'E')
    end
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(Puesto.all, 'M')
    end
    Octopus.using(:RF) do
      send_to_DWH_TEMP(TipoEmpleado.all, 'F')
    end
  end

  def self.extract_employee_data
    Octopus.using(:RF) do
      send_to_DWH_TEMP(Empleado.all, 'F')
    end
    Octopus.using(:E) do
      send_to_DWH_TEMP(EmpleadoEstacionamiento.all, 'E')
    end
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(Persona.all, 'M')
    end
  end

  def self.extract_tarjet_data
    Octopus.using(:E) do
      send_to_DWH_TEMP(Tarjeta.all, 'E')
    end
  end

  def self.extract_estancia_data
    Octopus.using(:E) do
      send_to_DWH_TEMP(Estancia.all, 'E')
      send_to_DWH_TEMP(DetalleEstanciaVideocamara.all, 'E')
    end
  end

  def self.extract_tipo_area_data
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(TipoArea.all, 'M')
    end
  end

  def self.extract_area_data
    Octopus.using(:E) do
      send_to_DWH_TEMP(AreaEstacionamiento.all, 'E')
    end
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(Area.all, 'M')
    end
  end

  def self.extract_cajero_data
    Octopus.using(:E) do
      send_to_DWH_TEMP(Cajero.all, 'E')
    end
  end

  def self.extract_cajero_estancia
    Octopus.using(:E) do
      send_to_DWH_TEMP(DetalleTarjetaCajero.all, 'E')
      send_to_DWH_TEMP(Tarifa.all, 'E')
    end
  end

  def self.extract_pasillo
    Octopus.using(:E) do
      send_to_DWH_TEMP(Pasillo.all, 'E')
    end
  end

  def self.extract_sensor
    Octopus.using(:E) do
      send_to_DWH_TEMP(Sensor.all, 'E')
    end
  end

  def self.extract_horario_disp
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(HorarioDisponible.all, 'M')
    end
  end

  def self.extract_horario_disp_detalle
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(DetalleHorarioDisponibleArea.all, 'M')
    end
  end

  def self.extract_locale
    Octopus.using(:RF) do
      send_to_DWH_TEMP(Locale.all, 'F')
    end
  end

  def self.extract_negocio
    Octopus.using(:RF) do
      send_to_DWH_TEMP(Negocio.all, 'F')
    end
  end

  def self.extract_local_negocio
    Octopus.using(:RF) do
      send_to_DWH_TEMP(LocalNegocio.all, 'F')
    end
  end

  def self.extract_descuento
    Octopus.using(:E) do
      send_to_DWH_TEMP(Descuento.all, 'E')
    end
  end

  def self.extract_tipo_accidente
    Octopus.using(:E) do
      send_to_DWH_TEMP(TiposAccidente.all, 'E')
    end
    Octopus.using(:MYL) do
      # send_to_DWH_TEMP(TiposAccidente.all, 'E')
    end
  end

  def self.extract_accidente
    Octopus.using(:E) do
      send_to_DWH_TEMP(Accidente.all, 'E')
    end
    Octopus.using(:MYL) do
      # send_to_DWH_TEMP(TiposAccidente.all, 'E')
    end
  end

  def self.extract_cliente
    Octopus.using(:RF) do
      send_to_DWH_TEMP(Cliente.all, 'F')
    end
  end

  def self.extract_contrato
    Octopus.using(:RF) do
      send_to_DWH_TEMP(Contrato.all, 'F')
    end
  end

  def self.extract_rentas
    Octopus.using(:RF) do
      send_to_DWH_TEMP(Rentas.all, 'F')
    end
  end

  def self.extract_proveedores
    Octopus.using(:E) do
      send_to_DWH_TEMP(Proveedores.all, 'E')
    end
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(ProveedoresMyl.all, 'M')
    end
  end

  def self.extract_categorias
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(Categorias.all, 'M')
    end
  end

  def self.extract_material_types
    Octopus.using(:E) do
      send_to_DWH_TEMP(TiposEquipo.all, 'E')
    end
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(TiposMateriales.all, 'M')
    end
  end

  def self.extract_materials
    Octopus.using(:E) do
      send_to_DWH_TEMP(Equipos.all, 'E')
    end
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(RecursosMateriales.all, 'M')
    end
  end

  def self.extract_proveedor_material
    Octopus.using(:E) do
      send_to_DWH_TEMP(DetalleProveedoresEquipos.all, 'E')
    end
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(MaterialesProveedores.all, 'M')
    end
  end

  def self.extract_solicitud_compra
    Octopus.using(:E) do
      send_to_DWH_TEMP(SolicitudesCompras.all, 'E')
    end
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(SolicitudesCompraMyl.all, 'M')
    end
  end

  def self.extract_servicios
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(Servicio.all, 'M')
    end
  end

  def self.extract_servicios_materiales
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(ServiciosMateriales.all, 'M')
    end
  end

  def self.extract_tareas
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(Tareas.all, 'M')
    end
  end

  def self.extract_tareas_materiales
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(TareasMateriales.all, 'M')
    end
  end

  def self.extract_bodega
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(SeccionesBodega.all, 'M')
    end
  end

  def self.extract_horarios
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(Horarios.all, 'M')
    end
  end

  def self.extract_supervisiones
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(Supervisiones.all, 'M')
    end
  end

  def self.extract_tipo_incidente
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(TiposIncidentes.all, 'M')
    end
  end

  def self.extract_incidentes
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(Incidentes.all, 'M')
    end
  end

  def self.extract_ordenes_servicio
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(OrdenesServicio.all, 'M')
    end
  end

  def self.extract_ordenes_servicio_personas
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(OrdenesServicioPersonas.all, 'M')
    end
  end

  def self.extract_contratistas
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(Contratista.all, 'M')
    end
  end

  def self.extract_contratistas_servicios
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(OrdenesServicioContratistas.all, 'M')
    end
  end

  def self.extract_areas_servicios
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(AreasServicios.all, 'M')
    end
  end

  def self.extract_orden_despacho
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(OrdenDespacho.all, 'M')
    end
    Octopus.using(:E) do
      send_to_DWH_TEMP(OrdenDespachoE.all, 'E')
    end
  end

  def self.extract_orden_despacho_materiales
    Octopus.using(:MYL) do
      send_to_DWH_TEMP(OrdenDespachoMateriales.all, 'M')
    end
    Octopus.using(:E) do
      send_to_DWH_TEMP(OrdenDespachoMaterialesE.all, 'E')
    end
  end

  def self.extract_ganancias
    Octopus.using(:RF) do
      send_to_DWH_TEMP(IngresoEstacionamiento.all, 'F')
      send_to_DWH_TEMP(GastoMantenimiento.all, 'F')
      send_to_DWH_TEMP(Pagos.all, 'F')
      send_to_DWH_TEMP(Abonos.all, 'F')
    end
  end



  def self.send_to_DWH_TEMP(objects, s)
    objects.each do |object|
      ## 0 es correcto / 1 es incorrecto
      object.valid?(s) ? save_on_DTWH_temp(object, object.class, s, 0) : save_on_DTWH_temp(object, object.class, s, 1)
    end
  end

  def self.save_on_DTWH_temp(object, k, s, wrong)
    sql = ''
    Octopus.using(:TEMP) do
      if k == TipoEmpleado || k == Puesto || k == TipoEmpleadoEstacionamiento
        if s == 'F'
          sql = "INSERT INTO dbo.TIPO_EMPLEADOS (nombre, salario, original_id, sistema, wrong) VALUES ('#{object[:nombre]}', #{object[:salario] ? object[:salario] : 0}, #{object[:id]}, '#{s}', #{wrong})"
        else
          sql = "INSERT INTO dbo.TIPO_EMPLEADOS (nombre, original_id, sistema, wrong) VALUES ('#{object[:nombre]}', #{object[:id]}, '#{s}', #{wrong})"
        end
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Empleado || k == Persona || k == EmpleadoEstacionamiento
        curp = s == 'F' ? object[:CURP] : object[:curp]

        if s == 'M'
          fk = find_foreign_key_from_original_using_system('dbo.TIPO_EMPLEADOS', object[:puesto], 0, s)
        else
          fk = find_foreign_key_from_original_using_system('dbo.TIPO_EMPLEADOS', object[:id_tipoempleado], 0, s)
        end

        if already_in_db?('curp', "#{curp}", 'dbo.EMPLEADOS')
          sql = "UPDATE dbo.EMPLEADOS SET id_tipoempleado = #{fk} WHERE curp = '#{curp}'" if fk != 0
        else
          sql = "INSERT INTO dbo.EMPLEADOS (nombre, curp, id_tipoempleado, original_id, sistema, wrong) VALUES ('#{object[:nombre]}', '#{curp}', #{fk}, #{object[:id]}, '#{s}', #{wrong})"
        end
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Tarjeta
        sql = "INSERT INTO dbo.TARJETA (estado, original_id, sistema, wrong) VALUES ('#{object[:estado]}', #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Estancia
        placa = ''
        Octopus.using(:E) do
          placa = DetalleEstanciaVideocamara.find_by(id_Estancia: object[:id]).placa
        end
        sql = "INSERT INTO dbo.ESTANCIA (original_id, fechainicio, fechafin, horainicio, horafin, duracion, estado, subtotal, total, placa, id_tarjeta, sistema, wrong) VALUES (#{object[:id]}, '#{object[:fecha_Inicio]}', '#{object[:fecha_Fin]}', '#{object[:hora_Inicio].strftime('%H:%M:%S')}', '#{object[:hora_Fin].strftime('%H:%M:%S')}', #{object[:duracion]}, '#{object[:estado]}', #{object[:subtotal]}, #{object[:total]}, '#{placa}', #{object[:id_Tarjeta]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == TipoArea
        if !already_in_db?('nombre', object[:nombre], 'TIPO_AREA')
          sql = "INSERT INTO dbo.TIPO_AREA (original_id, nombre, wrong, sistema) VALUES (#{object[:id]}, '#{object[:nombre]}', #{wrong}, '#{s}');"
          ActiveRecord::Base.connection.execute(sql)
        end
      end

      if k == AreaEstacionamiento
        sql = "INSERT INTO dbo.AREA (original_id, nombre, descripcion, wrong, sistema) VALUES (#{object[:id]}, '#{object[:nombre]}', '#{object[:descripcion]}', #{wrong}, '#{s}');"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Area
        tipo_area = find_foreign_key_from_original_using_system('TIPO_AREA', object[:tipo_area], 0, s)
        sql = "INSERT INTO dbo.AREA (original_id, nombre, id_tipoarea, wrong, sistema) VALUES (#{object[:id]}, '#{object[:nombre]}', #{tipo_area}, #{wrong}, '#{s}');"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Cajero
        area = find_foreign_key_from_original_using_system('AREA', object[:id_Area], 0, s)
        sql = "INSERT INTO dbo.CAJERO (original_id, dineroactual, fechaactual, periodicidadmantenimiento, estado, id_area, sistema, wrong) VALUES (#{object[:id]}, #{object[:dinero_Actual]}, '#{object[:fecha_Instalacion]}', '#{object[:periodicidad_Mantenimiento]}', '#{object[:estado]}', #{area}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == DetalleTarjetaCajero
        estancia = find_foreign_key_from_attr('E','estancia', 'id_Tarjeta', object[:id_Tarjeta])
        estancia = find_foreign_key_from_original_using_system('ESTANCIA', estancia, 0, s)
        hora = Time.new(object[:fecha].year, object[:fecha].month, object[:fecha].day, object[:hora].strftime('%H'), object[:hora].strftime('%M'), object[:hora].strftime('%S')).strftime('%Y-%m-%d %H:%M:%S')
        sql = "INSERT INTO dbo.ESTANCIA_CAJERO (tarifa, fechainicio, fechafin, id_estancia, sistema, wrong, original_id) VALUES (#{object[:id_Tarifa]}, '#{hora}', '#{hora}', #{estancia}, '#{s}', #{wrong}, #{object[:id]});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Tarifa
        if wrong == 1
          sql = "UPDATE dbo.ESTANCIA_CAJERO SET tarifa = '#{object[:costo]}', wrong = 1 WHERE tarifa = #{object[:id]}"
        else
          sql = "UPDATE dbo.ESTANCIA_CAJERO SET tarifa = '#{object[:costo]}' WHERE tarifa = #{object[:id]}"
        end
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Pasillo
        area = find_foreign_key_from_original_using_system('AREA', object[:id_Area], 0, s)
        sql = "INSERT INTO dbo.PASILLO (original_id, numero, cantidad_ocupados, cantidad_libres, id_area, sistema, wrong) VALUES (#{object[:id]}, #{object[:numero]}, #{object[:cantidad_ocupados]}, '#{object[:cantidad_libres]}', #{area}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Sensor
        pasillo = find_foreign_key_from_original_using_system('PASILLO', object[:id_pasillo],0, s)
        fecha = Time.new(object[:fecha].year, object[:fecha].month, object[:fecha].day, object[:hora].strftime('%H'), object[:hora].strftime('%M'), object[:hora].strftime('%S')).strftime('%Y-%m-%d %H:%M:%S')
        sql = "INSERT INTO dbo.SENSOR (estado, fecha, id_pasillo, sistema, wrong, original_id) VALUES ('#{object[:estado]}', '#{fecha}', #{pasillo}, '#{s}', #{wrong}, #{object[:id]});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == HorarioDisponible
        sql = "INSERT INTO dbo.HORARIO_DISPONIBLE (original_id, horainicio, horafin, dia, sistema, wrong) VALUES (#{object[:id]}, '#{object[:hora_inicio].strftime('%H:%M')}', '#{object[:hora_fin].strftime('%H:%M')}', '#{object[:dia]}', '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == DetalleHorarioDisponibleArea
        area = find_foreign_key_from_original_using_system('AREA', object[:area], 0, s)
        horario = find_foreign_key_from_original_using_system('HORARIO_DISPONIBLE', object[:horario_disp],0, s)
        sql = "INSERT INTO dbo.AREA_HORARIODISPONIBLE (id_horariodisponible, id_area, sistema, wrong, original_id) VALUES (#{horario}, #{area}, '#{s}', #{wrong}, #{object[:id]});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Locale
        ubicacion = find_foreign_key_from_attr('TEMP','AREA', 'nombre', object[:ubicacion])
        sql = "INSERT INTO dbo.LOCALES (numero, original_id, ubicacion, dimensiones, estado, costo, sistema, wrong) VALUES (#{object[:numero]}, #{object[:numero]}, '#{ubicacion}', '#{object[:dimensiones]}', '#{object[:estado]}',  #{object[:costo]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Negocio
        local = find_foreign_key_from_original_using_system('LOCALES', object[:id_locales],0, s)
        sql = "INSERT INTO dbo.NEGOCIOS (nombre, giro, estado, id_locales, original_id, sistema, wrong) VALUES ('#{object[:nombre]}', '#{object[:giro]}', '#{object[:estado]}', #{local},  #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == LocalNegocio
        local = find_foreign_key_from_original_using_system('LOCALES', object[:id_local], 0, s)
        negocio = find_foreign_key_from_original_using_system('NEGOCIOS', object[:id_negocio], 0, s)
        sql = "INSERT INTO dbo.LOCAL_NEGOCIO (fechainicio, fechafin, id_negocio, id_locales, original_id, sistema, wrong) VALUES ('#{object[:fechaini].strftime('%Y-%m-%d')}', '#{object[:fechafin].strftime('%Y-%m-%d')}', #{negocio},  #{local}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Descuento
        negocio = find_foreign_key_from_attr('TEMP', 'NEGOCIOS', 'nombre', object[:nombreNegocio])
        estancia = find_foreign_key_from_original_using_system('ESTANCIA', object[:id_Estancia], 0, s)
        sql = "INSERT INTO dbo.DESCUENTO (cantidad, id_negocio, id_estancia, original_id, sistema, wrong) VALUES (#{object[:cantidad]}, #{negocio},  #{estancia}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == TiposAccidente
        sql = "INSERT INTO dbo.TIPO_ACCIDENTE (nombre, original_id, sistema, wrong) VALUES ('#{object[:nombre]}', #{object[:id_tipoAccidente]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Accidente
        fecha = Time.new(object[:fecha].year, object[:fecha].month, object[:fecha].day, object[:hora].strftime('%H'), object[:hora].strftime('%M'), object[:hora].strftime('%S')).strftime('%Y-%m-%d %H:%M:%S')
        tipo_a = find_foreign_key_from_original_using_system('TIPO_ACCIDENTE', object[:id_tipoAccidente], 0, s)
        area = find_foreign_key_from_original_using_system('AREA', object[:id_Area], 0, s)
        sql = "INSERT INTO dbo.ACCIDENTES (fecha, id_tipoaccidente, id_area, original_id, sistema, wrong) VALUES ('#{fecha}', #{tipo_a}, #{area},  #{object[:id_Accidente]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Cliente
        sql = "INSERT INTO dbo.CLIENTE (nombre, RFC, original_id, sistema, wrong) VALUES ('#{object[:nombre]} #{object[:apellidos]}', '#{object[:rfc]}', #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Contrato
        sql = "INSERT INTO dbo.CONTRATO (fechainicio, fechafin, costo, id_cliente, id_local, original_id, sistema, wrong) VALUES ('#{object[:fechainicio].to_date}', '#{object[:fechafin].to_date}', #{object[:costo]}, #{object[:id_cliente]}, #{object[:id_local]}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Rentas
        contrato = find_foreign_key_from_attr('TEMP', 'contrato', 'id_local', object[:id_local].to_i)
        sql = "INSERT INTO dbo.RENTAS (fechacobro, statusretraso, statuspagado, id_contrato, original_id, sistema, wrong) VALUES ('#{object[:fechacobro].to_date}', '#{object[:statusretraso]}', '#{object[:statuspago]}', #{contrato}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Proveedores || k == ProveedoresMyl
        sql = "INSERT INTO dbo.PROVEEDOR (nombre, rfc, telefono, direccion, original_id, sistema, wrong) VALUES ('#{object[:nombre]}', '#{object[:rfc]}', '#{object[:telefono]}', '#{object[:direccion]}', #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Categorias
        sql = "INSERT INTO dbo.CATEGORIA (nombre, original_id, sistema, wrong) VALUES ('#{object[:nombre]}', #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if (k == TiposEquipo || k == TiposMateriales)
        sql = "INSERT INTO dbo.TIPO_MATERIAL (nombre, original_id, sistema, wrong) VALUES ('#{object[:nombre]}', #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Equipos
        tipo_id = find_foreign_key_from_original_using_system('TIPO_MATERIAL', object[:id_tipoEquipo], 0, s)
        sql = "INSERT INTO dbo.RECURSO_MATERIAL (original_id, nombre, tipo, sistema, wrong) VALUES (#{object[:id_Equipo]}, '#{object[:nombre]}', #{tipo_id}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == RecursosMateriales
        tipo_id = find_foreign_key_from_original_using_system('TIPO_MATERIAL', object[:tipo], 0, s)
        categoria_id = find_foreign_key_from_original_using_system('CATEGORIA', object[:categoria], 0, s)
        sql = "INSERT INTO dbo.RECURSO_MATERIAL (original_id, nombre, tipo, categoria, sistema, wrong) VALUES (#{object[:id]}, '#{object[:nombre]}', #{tipo_id}, #{categoria_id}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == DetalleProveedoresEquipos
        id_material = find_foreign_key_from_original_using_system('RECURSO_MATERIAL', object[:id_Equipo], 0, s)
        id_proveedor = find_foreign_key_from_original_using_system('PROVEEDOR', object[:id_Proveedor], 0, s)
        sql = "INSERT INTO dbo.PROVEEDOR_MATERIAL (costo, minimo, id_recursomaterial, id_proveedor, original_id, sistema, wrong) VALUES (#{object[:costo_Menudeo]}, 1, #{id_material}, #{id_proveedor}, #{object[:id_ProveedorEquipo]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == MaterialesProveedores
        id_material = find_foreign_key_from_original_using_system('RECURSO_MATERIAL', object[:recurso_material], 0, s)
        id_proveedor = find_foreign_key_from_original_using_system('PROVEEDOR', object[:proveedor], 0, s)
        sql = "INSERT INTO dbo.PROVEEDOR_MATERIAL (costo, minimo, id_recursomaterial, id_proveedor, sistema, wrong, original_id) VALUES (#{object[:costo]}, #{object[:minimo]}, #{id_material}, #{id_proveedor}, '#{s}', #{wrong}, #{object[:id]});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == SolicitudesCompras
        id_empleado = find_foreign_key_from_original_using_system('EMPLEADOS', object[:id_Empleado], 0, s)
        id_proveedor = find_foreign_key_from_original_using_system('PROVEEDOR', object[:id_Proveedor], 0, s)
        sql = "INSERT INTO dbo.SOLICITUD_COMPRA (cantidad_total, fechaemision, costototal, id_empleado, id_proveedor, original_id, sistema, wrong) VALUES (#{object[:cantidad_Total]}, '#{object[:fecha_Emision]}', #{object[:costo_Total]}, #{id_empleado}, #{id_proveedor}, #{object[:id_Solicitud]}, '#{s}', #{wrong} );"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == SolicitudesCompraMyl
        id_empleado = find_foreign_key_from_original_using_system('EMPLEADOS', object[:persona], 0, s)
        id_proveedor = find_foreign_key_from_original_using_system('PROVEEDOR', object[:proveedor], 0, s)
        sql = "INSERT INTO dbo.SOLICITUD_COMPRA (cantidad_total, fechaemision, costototal, id_empleado, id_proveedor, original_id, sistema, wrong) VALUES (#{object[:cantidad_total]}, '#{object[:fecha_emision]}', #{object[:costo_total]}, #{id_empleado}, #{id_proveedor}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Servicio
        sql = "INSERT INTO dbo.SERVICIO (nombre, duracion, tipo_servicio, original_id, sistema, wrong) VALUES ('#{object[:nombre]}', #{object[:duracion]}, #{object[:tipo_servicio]}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == ServiciosMateriales
        id_servicio = find_foreign_key_from_original_using_system('SERVICIO', object[:servicio], 0, s)
        id_material = find_foreign_key_from_original_using_system('RECURSO_MATERIAL', object[:recurso_material], 0, s)
        sql = "INSERT INTO dbo.SERVICIO_MATERIAL (cantidad, id_servicio, recurso_material, original_id, sistema, wrong) VALUES ('#{object[:cantidad]}', #{id_servicio}, #{id_material}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Tareas
        id_servicio = find_foreign_key_from_original_using_system('SERVICIO', object[:servicio], 0, s)
        id_area = find_foreign_key_from_original_using_system('AREA', object[:area], 0, s)
        sql = "INSERT INTO dbo.TAREA (duracion, id_servicio, id_area, original_id, sistema, wrong) VALUES ('#{object[:duracion]}', #{id_servicio}, #{id_area}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == TareasMateriales
        id_tarea = find_foreign_key_from_original_using_system('TAREA', object[:tarea], 0, s)
        id_material = find_foreign_key_from_original_using_system('RECURSO_MATERIAL', object[:recurso_material], 0, s)
        id_supervisor = find_foreign_key_from_original_using_system('EMPLEADOS', object[:persona], 0, s)
        sql = "INSERT INTO dbo.TAREA_MATERIAL (cantidadentregada, id_tarea, id_recursomaterial, id_empleado, original_id, sistema, wrong) VALUES ('#{object[:cantidad_entregada]}', #{id_tarea}, #{id_material}, #{id_supervisor}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == SeccionesBodega
        id_material = find_foreign_key_from_original_using_system('RECURSO_MATERIAL', object[:recurso_material], 0, s)
        sql = "INSERT INTO dbo.SECCION_BODEGA (nombre, tamaño, estante, numero, id_recursomaterial, original_id, sistema, wrong) VALUES ('#{object[:nombre]}', #{object[:tamaño]}, #{object[:estante]}, #{object[:numero]}, #{id_material}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Horarios
        id_persona = find_foreign_key_from_original_using_system('EMPLEADOS', object[:persona], 0, s)
        id_tarea = find_foreign_key_from_original_using_system('TAREA', object[:tarea], 0, s)
        sql = "INSERT INTO dbo.HORARIO (horainicio, horafin, fechainicio, fechafin, id_empleado, id_tarea, original_id, sistema, wrong) VALUES ('#{object[:hora_inicio].strftime('%H:%M:%S')}', '#{object[:hora_fin].strftime('%H:%M:%S')}', '#{object[:fecha_inicio]}', '#{object[:fecha_fin]}', #{id_persona}, #{id_tarea}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Supervisiones
        id_persona = find_foreign_key_from_original_using_system('EMPLEADOS', object[:persona], 0, s)
        id_tarea = find_foreign_key_from_original_using_system('TAREA', object[:tarea], 0, s)
        sql = "INSERT INTO dbo.SUPERVISION (valoracion, id_empleado, id_tarea, original_id, sistema, wrong) VALUES (#{object[:valoracion]}, #{id_persona}, #{id_tarea}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == TiposIncidentes
        sql = "INSERT INTO dbo.TIPO_INCIDENTE (nombre, descripcion, original_id, sistema, wrong) VALUES ('#{object[:nombre]}', '#{object[:descripcion]}', #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Incidentes
        persona = find_foreign_key_from_original_using_system('EMPLEADOS', object[:persona], 0, s)
        id_material = find_foreign_key_from_original_using_system('RECURSO_MATERIAL', object[:recurso_material], 0, s)
        sql = "INSERT INTO dbo.INCIDENTE (fecha, clavenotacredito, clavenotadebito, id_tipoincidente, id_empleado, id_recurso_material, original_id, sistema, wrong) VALUES ('#{object[:fecha].strftime('%Y-%m-%d')}', '#{object[:clave_nota_credito]}', '#{object[:clave_nota_debito]}', #{object[:tipo_incidente]}, #{persona}, #{id_material}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == OrdenesServicio
        persona = find_foreign_key_from_original_using_system('EMPLEADOS', object[:persona], 0, s)
        id_tarea = find_foreign_key_from_original_using_system('TAREA', object[:tarea], 0, s)

        sql = "INSERT INTO dbo.ORDEN_SERVICIO (fecha, prioridad, id_tarea, id_empleado, original_id, sistema, wrong) VALUES ('#{object[:fecha].strftime('%Y-%m-%d')}', '#{object[:prioridad]}', #{id_tarea}, #{persona}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == OrdenesServicioPersonas
        id_os = find_foreign_key_from_original_using_system('ORDEN_SERVICIO', object[:orden_servicio], 0, s)
        persona = find_foreign_key_from_original_using_system('EMPLEADOS', object[:persona], 0, s)

        sql = "INSERT INTO dbo.ORDENSERVICIO_PERSONA (id_ordenservicio, id_empleado, original_id, sistema, wrong) VALUES (#{id_os}, #{persona}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Contratista
        sql = "INSERT INTO dbo.CONTRATANTE (nombre, direccion, numero, original_id, sistema, wrong) VALUES ('#{object[:nombre]}', '#{object[:direccion]}', '#{object[:numero]}', #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == OrdenesServicioContratistas
        id_os = find_foreign_key_from_original_using_system('ORDEN_SERVICIO', object[:orden_servicio], 0, s)
        id_cont = find_foreign_key_from_original_using_system('CONTRATANTE', object[:contratista], 0, s)

        sql = "INSERT INTO dbo.ORDENSERVICIO_CONTRATANTE (costo, tiempo, id_ordenservicio, id_contratante, original_id, sistema, wrong) VALUES (#{object[:costo]}, #{object[:tiempo]}, #{id_os}, #{id_cont}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == AreasServicios
        id_ta = find_foreign_key_from_original_using_system('TIPO_AREA', object[:tipo_area], 0, s)
        id_s = find_foreign_key_from_original_using_system('SERVICIO', object[:servicio], 0, s)

        sql = "INSERT INTO dbo.AREA_SERVICIO (periodicidad, id_servicio, id_tipoarea, original_id, sistema, wrong) VALUES (#{object[:periodicidad]}, #{id_s}, #{id_ta}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == OrdenDespacho
        id_sc = find_foreign_key_from_original_using_system('SOLICITUD_COMPRA', object[:solicitud_compra], 0, s)

        sql = "INSERT INTO dbo.ORDEN_DESPACHO (fechaentrega, id_solicitud, original_id, sistema, wrong) VALUES ('#{object[:fecha_entrega].strftime('%Y-%m-%d')}', #{id_sc}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == OrdenDespachoE
        id_sc = find_foreign_key_from_original_using_system('SOLICITUD_COMPRA', object[:id_Solicitud], 0, s)

        sql = "INSERT INTO dbo.ORDEN_DESPACHO (fechaentrega, id_solicitud, original_id, sistema, wrong) VALUES ('#{object[:fecha_Entrega].strftime('%Y-%m-%d')}', #{id_sc}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == OrdenDespachoMateriales
        id_od = find_foreign_key_from_original_using_system('ORDEN_DESPACHO', object[:orden_despacho], 0, s)
        id_rm = find_foreign_key_from_original_using_system('RECURSO_MATERIAL', object[:recurso_material], 0, s)

        sql = "INSERT INTO dbo.ORDENDESPACHO_MATERIAL (cantidadrecibida, fechadecaducidad, id_ordendespacho, id_recursomaterial, original_id, sistema, wrong) VALUES (#{object[:cantidad_recibida]}, '#{object[:fecha_caducidad]}', #{id_od}, #{id_rm}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == OrdenDespachoMaterialesE
        id_od = find_foreign_key_from_original_using_system('ORDEN_DESPACHO', object[:id_ordenDespacho], 0, s)
        id_rm = find_foreign_key_from_original_using_system('RECURSO_MATERIAL', object[:id_Equipo], 0, s)

        sql = "INSERT INTO dbo.ORDENDESPACHO_MATERIAL (cantidadrecibida, id_ordendespacho, id_recursomaterial, original_id, sistema, wrong) VALUES (#{object[:cantidad]}, #{id_od}, #{id_rm}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == IngresoEstacionamiento
        sql = "INSERT INTO dbo.GANANCIAS (ingresos, egresos, fechacorte, sistema, wrong) VALUES (#{object[:cantidad]}, 0, '#{object[:fecha].strftime('%Y-%m-%d')}', '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)

        id_g = ActiveRecord::Base.connection.exec_query("SELECT TOP 1(id) FROM GANANCIAS ORDER BY ID DESC").rows[0][0]

        sql = "INSERT INTO dbo.INGRESO_ESTACIONAMIENTO (cantidad, fecha, id_ganacia, original_id, sistema, wrong) VALUES (#{object[:cantidad]}, '#{object[:fecha].strftime('%Y-%m-%d')}', #{id_g}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == GastoMantenimiento
        sql = "INSERT INTO dbo.GANANCIAS (egresos, ingresos, fechacorte, sistema, wrong) VALUES (#{object[:cantidad]}, 0, '#{object[:fecha].strftime('%Y-%m-%d')}', '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)

        id_g = ActiveRecord::Base.connection.exec_query("SELECT TOP 1(id) FROM GANANCIAS ORDER BY ID DESC").rows[0][0]

        sql = "INSERT INTO dbo.EGRESO_MANTENIMIENTO (cantidad, fecha, id_ganancia, original_id, sistema, wrong) VALUES (#{object[:cantidad]}, '#{object[:fecha].strftime('%Y-%m-%d')}', #{id_g}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Pagos
        sql = "INSERT INTO dbo.GANANCIAS (egresos, ingresos, fechacorte, sistema, wrong) VALUES (#{object[:monto]}, 0, '#{object[:fecha].strftime('%Y-%m-%d')}', '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)

        id_g = ActiveRecord::Base.connection.exec_query("SELECT TOP 1(id) FROM GANANCIAS ORDER BY ID DESC").rows[0][0]

        id_e = find_foreign_key_from_original_using_system('EMPLEADOS', object[:id_emp].to_i, 0, s)

        sql = "INSERT INTO dbo.PAGOS (monto, fecha, id_ganancia, id_empleado, original_id, sistema, wrong) VALUES (#{object[:monto]}, '#{object[:fecha].strftime('%Y-%m-%d')}', #{id_g}, #{id_e}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Abonos
        sql = "INSERT INTO dbo.GANANCIAS (ingresos, egresos, fechacorte, sistema, wrong) VALUES (#{object[:monto]}, 0, '#{object[:fechacobro].strftime('%Y-%m-%d')}', '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)

        id_g = ActiveRecord::Base.connection.exec_query("SELECT TOP 1(id) FROM GANANCIAS ORDER BY ID DESC").rows[0][0]

        id_e = find_foreign_key_from_original_using_system('RENTAS', object[:id_renta].to_i, 0, s)

        sql = "INSERT INTO dbo.ABONOS (monto, fechapago, saldorestante, id_ganancia, id_renta, original_id, sistema, wrong) VALUES (#{object[:monto]}, '#{object[:fechacobro].strftime('%Y-%m-%d')}', #{object[:saldorestante]}, #{id_g}, #{id_e}, #{object[:id]}, '#{s}', #{wrong});"
        ActiveRecord::Base.connection.execute(sql)
      end

    end
  end

  def self.already_in_db?(attri, val, table)
    if val.is_a?(String)
      sql = "SELECT * FROM #{table} where #{attri} = '#{val}'"
    else
      sql = "SELECT * FROM #{table} where #{attri} = #{val}"
    end
    ActiveRecord::Base.connection.execute(sql) > 0
  end


  def self.find_foreign_key_from_original(table, original_id, i)
    Octopus.using(:DTWH) do
      sql = "SELECT id from #{table} where original_id = '#{original_id}'"
      result = ActiveRecord::Base.connection.exec_query(sql).rows
      result[i].present? ? result[i][0] : 'null'

    end
  end

  def self.find_foreign_key_from_original_using_system(table, original_id, i, s)
    Octopus.using(:TEMP) do
      sql = "SELECT id from #{table} where original_id = '#{original_id}' and sistema = '#{s}'"
      result = ActiveRecord::Base.connection.exec_query(sql).rows
      result[i].present? ? result[i][0] : 'null'
    end
  end

  def self.find_foreign_key_from_attr(db, table, attri, attr_val)
    Octopus.using(:"#{db}") do
      sql = "SELECT id from #{table} where #{attri} = '#{attr_val}'"
      result = ActiveRecord::Base.connection.exec_query(sql).rows
      result = result.present? ? result[0][0] : 'null'
    end
  end
end
