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
  end

  def self.extract_employee_type_data
    Octopus.using(:E) do
      send_to_DWH(TipoEmpleadoEstacionamiento.all, 'E')
    end
    Octopus.using(:MYL) do
      send_to_DWH(Puesto.all, 'M')
    end
    Octopus.using(:RF) do
      send_to_DWH(TipoEmpleado.all, 'F')
    end
  end

  def self.extract_employee_data
    Octopus.using(:RF) do
      send_to_DWH(Empleado.all, 'F')
    end
    Octopus.using(:E) do
      send_to_DWH(EmpleadoEstacionamiento.all, 'E')
    end
    Octopus.using(:MYL) do
      send_to_DWH(Persona.all, 'M')
    end
  end

  def self.extract_tarjet_data
    Octopus.using(:E) do
      send_to_DWH(Tarjeta.all, 'E')
    end
  end

  def self.extract_estancia_data
    Octopus.using(:E) do
      send_to_DWH(Estancia.all, 'E')
      send_to_DWH(DetalleEstanciaVideocamara.all, 'E')
    end
  end

  def self.extract_tipo_area_data
    Octopus.using(:MYL) do
      send_to_DWH(TipoArea.all, 'M')
    end
  end

  def self.extract_area_data
    Octopus.using(:E) do
      send_to_DWH(AreaEstacionamiento.all, 'E')
    end
    Octopus.using(:MYL) do
      send_to_DWH(Area.all, 'M')
    end
  end

  def self.extract_cajero_data
    Octopus.using(:E) do
      send_to_DWH(Cajero.all, 'E')
    end
  end

  def self.extract_cajero_estancia
    Octopus.using(:E) do
      send_to_DWH(DetalleTarjetaCajero.all, 'E')
      send_to_DWH(Tarifa.all, 'E')
    end
  end

  def self.extract_pasillo
    Octopus.using(:E) do
      send_to_DWH(Pasillo.all, 'E')
    end
  end

  def self.extract_sensor
    Octopus.using(:E) do
      send_to_DWH(Sensor.all, 'E')
    end
  end

  def self.extract_horario_disp
    Octopus.using(:MYL) do
      send_to_DWH(HorarioDisponible.all, 'M')
    end
  end

  def self.extract_horario_disp_detalle
    Octopus.using(:MYL) do
      send_to_DWH(DetalleHorarioDisponibleArea.all, 'M')
    end
  end

  def self.extract_locale
    Octopus.using(:RF) do
      send_to_DWH(Locale.all, 'F')
    end
  end

  def self.extract_negocio
    Octopus.using(:RF) do
      send_to_DWH(Negocio.all, 'F')
    end
  end

  def self.extract_local_negocio
    Octopus.using(:RF) do
      send_to_DWH(LocalNegocio.all, 'F')
    end
  end

  def self.extract_descuento
    Octopus.using(:E) do
      send_to_DWH(Descuento.all, 'E')
    end
  end

  def self.extract_tipo_accidente
    Octopus.using(:E) do
      send_to_DWH(TiposAccidente.all, 'E')
    end
    Octopus.using(:MYL) do
      # send_to_DWH(TiposAccidente.all, 'E')
    end
  end

  def self.extract_accidente
    Octopus.using(:E) do
      send_to_DWH(Accidente.all, 'E')
    end
    Octopus.using(:MYL) do
      # send_to_DWH(TiposAccidente.all, 'E')
    end
  end

  def self.extract_cliente
    Octopus.using(:RF) do
      send_to_DWH(Cliente.all, 'F')
    end
  end

  def self.extract_contrato
    Octopus.using(:RF) do
      send_to_DWH(Contrato.all, 'F')
    end
  end

  def self.extract_rentas
    Octopus.using(:RF) do
      send_to_DWH(Rentas.all, 'F')
    end
  end

  def self.extract_proveedores
    Octopus.using(:E) do
      send_to_DWH(Proveedores.all, 'E')
    end
    Octopus.using(:MYL) do
      send_to_DWH(ProveedoresMyl.all, 'M')
    end
  end

  def self.extract_categorias
    Octopus.using(:MYL) do
      send_to_DWH(Categorias.all, 'M')
    end
  end

  def self.extract_material_types
    Octopus.using(:E) do
      send_to_DWH(TiposEquipo.all, 'E')
    end
    Octopus.using(:MYL) do
      send_to_DWH(TiposMateriales.all, 'M')
    end
  end

  def self.extract_materials
    Octopus.using(:E) do
      send_to_DWH(Equipos.all, 'E')
    end
    Octopus.using(:MYL) do
      send_to_DWH(RecursosMateriales.all, 'M')
    end
  end

  def self.extract_proveedor_material
    Octopus.using(:E) do
      send_to_DWH(DetalleProveedoresEquipos.all, 'E')
    end
    Octopus.using(:MYL) do
      send_to_DWH(MaterialesProveedores.all, 'M')
    end
  end

  def self.extract_solicitud_compra
    Octopus.using(:E) do
      send_to_DWH(SolicitudesCompras.all, 'E')
    end
    Octopus.using(:MYL) do
      send_to_DWH(SolicitudesCompraMyl.all, 'M')
    end
  end

  def self.extract_servicios
    Octopus.using(:MYL) do
      send_to_DWH(Servicio.all, 'M')
    end
  end

  def self.send_to_DWH(objects, s)
    objects.each do |object|
      object.valid?(s) ? save_on_DTWH(object, object.class, s) : save_on_TEMP(object, s, object.class)
    end
  end

  def self.save_on_DTWH(object, k, s)
    sql = ''
    Octopus.using(:DTWH) do
      if k == TipoEmpleado || k == Puesto
        if already_in_db?('nombre', object[:nombre], 'dbo.TIPO_EMPLEADOS')
          if s == 'F'
            sql = "UPDATE dbo.TIPO_EMPLEADOS SET salario = #{object[:salario] ? object[:salario] : 0} WHERE nombre = '#{object[:nombre]}'"
          end
        else
          if s == 'F'
            sql = "INSERT INTO dbo.TIPO_EMPLEADOS (nombre, salario) VALUES ('#{object[:nombre]}', #{object[:salario] ? object[:salario] : 0})"
          else
            sql = "INSERT INTO dbo.TIPO_EMPLEADOS (nombre) VALUES ('#{object[:nombre]}')"
          end
        end
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Empleado || k == Persona || k == EmpleadoEstacionamiento
        curp = s == 'F' ? object[:CURP] : object[:curp]
        fk = find_foreign_key('E', 'empleado_estacionamientos', 'id_tipoEmpleado', 'tipo_empleado_estacionamientos', 'id', 'nombre', 'curp', curp, 'dbo.TIPO_EMPLEADOS', 'nombre') if s == 'E'
        fk = find_foreign_key('MYL', 'personas', 'puesto', 'puestos', 'id', 'nombre', 'curp', curp, 'dbo.TIPO_EMPLEADOS', 'nombre') if s == 'M'
        fk = find_foreign_key('RF', 'empleados', 'id_tipoempleado', 'tipo_empleados', 'id', 'nombre', 'curp', curp, 'dbo.TIPO_EMPLEADOS', 'nombre') if s =='F'
        if already_in_db?('curp', "#{curp}", 'dbo.EMPLEADOS')
          sql = "UPDATE dbo.EMPLEADOS SET id_tipoempleado = #{fk} WHERE curp = '#{curp}'" if fk != 0
        else
          sql = "INSERT INTO dbo.EMPLEADOS (nombre, curp, id_tipoempleado) VALUES ('#{object[:nombre]}', '#{curp}', #{fk})"
        end
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Tarjeta
        sql = "INSERT INTO dbo.TARJETA (id_original, estado) VALUES (#{object[:id]}, '#{object[:estado]}');"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Estancia
        placa = ''
        Octopus.using(:E) do
          placa = DetalleEstanciaVideocamara.find_by(id_Estancia: object[:id])
        end
        sql = "INSERT INTO dbo.ESTANCIA (original_id, fechainicio, fechafin, horainicio, horafin, duracion, estado, subtotal, total) VALUES (#{object[:id]}, '#{object[:fecha_Inicio]}', '#{object[:fecha_Fin]}', '#{object[:hora_Inicio].strftime('%H:%M:%S')}', '#{object[:hora_Fin].strftime('%H:%M:%S')}', #{object[:duracion]}, '#{object[:estado]}', #{object[:subtotal]}, #{object[:total]});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == DetalleEstanciaVideocamara
        sql = "UPDATE dbo.ESTANCIA SET placa = '#{object[:placa]}' WHERE id = #{object[:id_Estancia]}"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == TipoArea
        if !already_in_db?('nombre', object[:nombre], 'TIPO_AREA')
          sql = "INSERT INTO dbo.TIPO_AREA (original_id, nombre) VALUES (#{object[:id]}, '#{object[:nombre]}');"
          ActiveRecord::Base.connection.execute(sql)
        end
      end

      if k == AreaEstacionamiento
        if !already_in_db?('nombre', object[:nombre], 'AREA')
          sql = "INSERT INTO dbo.AREA (original_id, nombre, descripcion) VALUES (#{object[:id]}, '#{object[:nombre]}', '#{object[:descripcion]}');"
          ActiveRecord::Base.connection.execute(sql)
        end
      end

      if k == Area
        tipo_area = find_foreign_key_from_original('TIPO_AREA', object[:tipo_area], 0)
        if !already_in_db?('nombre', object[:nombre], 'AREA')
          sql = "INSERT INTO dbo.AREA (original_id, nombre, id_tipoarea) VALUES (#{object[:id]}, '#{object[:nombre]}', #{tipo_area});"
          ActiveRecord::Base.connection.execute(sql)
        end
      end

      if k == Cajero
        area = find_foreign_key_from_original('AREA', object[:id_Area], 1)
        sql = "INSERT INTO dbo.CAJERO (original_id, dineroactual, fechaactual, periodicidadmantenimiento, estado, id_area) VALUES (#{object[:id]}, #{object[:dinero_Actual]}, '#{object[:fecha_Instalacion]}', '#{object[:periodicidad_Mantenimiento]}', '#{object[:estado]}', #{area});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == DetalleTarjetaCajero && @new
        estancia = find_foreign_key_from_attr('E','estancia', 'id_Tarjeta', object[:id_Tarjeta])
        estancia = find_foreign_key_from_original('ESTANCIA', estancia, 0)
        hora = Time.new(object[:fecha].year, object[:fecha].month, object[:fecha].day, object[:hora].strftime('%H'), object[:hora].strftime('%M'), object[:hora].strftime('%S')).strftime('%Y-%m-%d %H:%M:%S')
        sql = "INSERT INTO dbo.ESTANCIA_CAJERO (tarifa, fechainicio, fechafin, id_estancia) VALUES (#{object[:id_Tarifa]}, '#{hora}', '#{hora}', #{estancia});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == DetalleTarjetaCajero && !@new
        sql = "INSERT INTO dbo.ESTANCIA_CAJERO (tarifa, fechainicio, fechafin, id_estancia) VALUES (#{object[:tarifa]}, #{object[:fechainicio]}, '#{object[:fechafin]}', '#{object[:id_estancia]}');"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Tarifa
        sql = "UPDATE dbo.ESTANCIA_CAJERO SET tarifa = '#{object[:costo]}' WHERE tarifa = #{object[:id]}"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Pasillo
        area = find_foreign_key_from_original('AREA', object[:id_Area],1)
        sql = "INSERT INTO dbo.PASILLO (original_id, numero, cantidad_ocupados, cantidad_libres, id_area) VALUES (#{object[:id]}, #{object[:numero]}, #{object[:cantidad_ocupados]}, '#{object[:cantidad_libres]}', #{area});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Sensor && @new
        pasillo = find_foreign_key_from_original('PASILLO', object[:id_pasillo],0)
        fecha = Time.new(object[:fecha].year, object[:fecha].month, object[:fecha].day, object[:hora].strftime('%H'), object[:hora].strftime('%M'), object[:hora].strftime('%S')).strftime('%Y-%m-%d %H:%M:%S')
        sql = "INSERT INTO dbo.SENSOR (estado, fecha, id_pasillo) VALUES ('#{object[:estado]}', '#{fecha}', #{pasillo});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Sensor && !@new
        sql = "INSERT INTO dbo.SENSOR (estado, fecha, id_pasillo) VALUES ('#{object[:estado]}', '#{object[:fecha]}', #{pasillo});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == HorarioDisponible
        sql = "INSERT INTO dbo.HORARIO_DISPONIBLE (original_id, horainicio, horafin, dia) VALUES (#{object[:id]}, '#{object[:hora_inicio].strftime('%H:%M')}', '#{object[:hora_fin].strftime('%H:%M')}', '#{object[:dia]}');"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == DetalleHorarioDisponibleArea
        area = find_foreign_key_from_original('AREA', object[:area], 0)
        horario = find_foreign_key_from_original('HORARIO_DISPONIBLE', object[:horario_disp],0)
        sql = "INSERT INTO dbo.AREA_HORARIODISPONIBLE (id_horariodisponible, id_area) VALUES (#{horario}, #{area});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Locale
        ubicacion = find_foreign_key_from_attr('DTWH','AREA', 'nombre', object[:ubicacion])
        sql = "INSERT INTO dbo.LOCALES (numero, original_id, ubicacion, dimensiones, estado, costo) VALUES (#{object[:numero]}, #{object[:numero]}, '#{ubicacion}', '#{object[:dimensiones]}', '#{object[:estado]}',  #{object[:costo]});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Negocio
        local = find_foreign_key_from_original('LOCALES', object[:id_locales],0)
        sql = "INSERT INTO dbo.NEGOCIOS (nombre, giro, estado, id_locales, original_id) VALUES ('#{object[:nombre]}', '#{object[:giro]}', '#{object[:estado]}', #{local},  #{object[:id]});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == LocalNegocio
        local = find_foreign_key_from_original('LOCALES', object[:id_local], 0)
        negocio = find_foreign_key_from_original('NEGOCIOS', object[:id_negocio], 0)
        sql = "INSERT INTO dbo.LOCAL_NEGOCIO (fechainicio, fechafin, id_negocio, id_locales) VALUES ('#{object[:fechaini].strftime('%Y-%m-%d')}', '#{object[:fechafin].strftime('%Y-%m-%d')}', #{negocio},  #{local});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Descuento && @new
        negocio = find_foreign_key_from_attr('DTWH', 'NEGOCIOS', 'nombre', object[:nombreNegocio])
        estancia = find_foreign_key_from_original('ESTANCIA', object[:id_Estancia], 0)
        sql = "INSERT INTO dbo.DESCUENTO (cantidad, id_negocio, id_estancia) VALUES (#{object[:cantidad]}, #{negocio},  #{estancia});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Descuento && !@new
        sql = "INSERT INTO dbo.DESCUENTO (cantidad, id_negocio, id_estancia) VALUES (#{object[:cantidad]}, #{object[:id_negocio]},  #{object[:id_estancia]});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == TiposAccidente && @new
        sql = "INSERT INTO dbo.TIPO_ACCIDENTE (nombre, original_id) VALUES ('#{object[:nombre]}', #{object[:id_tipoAccidente]});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == TiposAccidente && !@new
        sql = "INSERT INTO dbo.TIPO_ACCIDENTE (nombre, original_id) VALUES ('#{object[:nombre]}', #{object[:original_id]});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Accidente && @new
        fecha = Time.new(object[:fecha].year, object[:fecha].month, object[:fecha].day, object[:hora].strftime('%H'), object[:hora].strftime('%M'), object[:hora].strftime('%S')).strftime('%Y-%m-%d %H:%M:%S')
        tipo_a = find_foreign_key_from_original('TIPO_ACCIDENTE', object[:id_tipoAccidente], 0)
        area = find_foreign_key_from_original('AREA', object[:id_Area], 1)
        sql = "INSERT INTO dbo.ACCIDENTES (fecha, id_tipoaccidente, id_area) VALUES ('#{fecha}', #{tipo_a}, #{area});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Accidente && !@new
        tipo_a = find_foreign_key_from_original('TIPO_ACCIDENTE', object[:id_tipoaccidente], 0)
        area = find_foreign_key_from_original('AREA', object[:id_area], 1)
        sql = "INSERT INTO dbo.ACCIDENTES (fecha, id_tipoaccidente, id_area) VALUES ('#{object[:fecha]}', #{tipo_a}, #{area});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Cliente && @new
        sql = "INSERT INTO dbo.CLIENTE (nombre, RFC) VALUES ('#{object[:nombres]} #{object[:apellidos]}', '#{object[:rfc]}');"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Cliente && !@new
        sql = "INSERT INTO dbo.CLIENTE (nombre, RFC) VALUES ('#{object[:nombre]}', '#{object[:RFC]}');"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Contrato
        sql = "INSERT INTO dbo.CONTRATO (fechainicio, fechafin, costo, id_cliente, id_local, original_id) VALUES ('#{object[:fechainicio].to_date}', '#{object[:fechafin].to_date}', #{object[:costo]}, #{object[:id_cliente]}, #{object[:id_local]}, #{object[:id]});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Rentas && @new
        contrato = find_foreign_key_from_attr('DTWH', 'contrato', 'id_local', object[:id_local].to_i)
        sql = "INSERT INTO dbo.RENTAS (fechacobro, statusretraso, statuspagado, id_contrato) VALUES ('#{object[:fechacobro].to_date}', '#{object[:statusretraso]}', '#{object[:statuspago]}', #{contrato});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Rentas && !@new
        contrato = find_foreign_key_from_attr('DTWH', 'contrato', 'id_local', object[:id_local].to_i)
        sql = "INSERT INTO dbo.RENTAS (fechacobro, statusretraso, statuspagado, id_contrato) VALUES ('#{object[:fechacobro].to_date}', '#{object[:statusretraso]}', '#{object[:statuspagado]}', #{contrato});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if (k == Proveedores || k == ProveedoresMyl) && @new
        sql = "INSERT INTO dbo.RENTAS (nombre, rfc, telefono, direccion, original_id) VALUES ('#{object[:nombre]}', '#{object[:rfc]}', '#{object[:telefono]}', '#{object[:telefono]}', #{object[:id]});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if (k == Proveedores || k == ProveedoresMyl) && !@new
        sql = "INSERT INTO dbo.PROVEEDOR (nombre, rfc, telefono, direccion, original_id) VALUES ('#{object[:nombre]}', '#{object[:rfc]}', '#{object[:telefono]}', '#{object[:telefono]}', #{object[:original_id]});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Categorias && @new
        sql = "INSERT INTO dbo.CATEGORIA (nombre, original_id) VALUES ('#{object[:nombre]}', #{object[:id]});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Categorias && !@new
        sql = "INSERT INTO dbo.CATEGORIA (nombre, original_id) VALUES ('#{object[:nombre]}', #{object[:original_id]});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if (k == TiposEquipo || k == TiposMateriales) && @new
        sql = "INSERT INTO dbo.TIPO_MATERIAL (nombre, original_id) VALUES ('#{object[:nombre]}', #{object[:id]});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if (k == TiposEquipo || k == TiposMateriales) && !@new
        sql = "INSERT INTO dbo.TIPO_MATERIAL (nombre, original_id) VALUES ('#{object[:nombre]}', #{object[:original_id]});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Equipos && @new
        tipo_id = find_foreign_key_from_original('TIPO_MATERIAL', object[:id_tipoEquipo], 0)
        sql = "INSERT INTO dbo.RECURSO_MATERIAL (original_id, nombre, tipo) VALUES (#{object[:id]}, '#{object[:nombre]}', #{tipo_id});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == RecursosMateriales && @new
        tipo_id = find_foreign_key_from_original('TIPO_MATERIAL', object[:tipo], 1)
        categoria_id = find_foreign_key_from_original('CATEGORIA', object[:categoria], 0)
        sql = "INSERT INTO dbo.RECURSO_MATERIAL (original_id, nombre, tipo, categoria) VALUES (#{object[:id]}, '#{object[:nombre]}', #{tipo_id}, #{categoria_id});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Equipos && !@new
        tipo_id = find_foreign_key_from_original('TIPO_MATERIAL', object[:tipo], 0)
        sql = "INSERT INTO dbo.RECURSO_MATERIAL (original_id, nombre, tipo) VALUES (#{object[:id]}, '#{object[:nombre]}', #{tipo_id});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == RecursosMateriales && !@new
        tipo_id = find_foreign_key_from_original('TIPO_MATERIAL', object[:tipo], 1)
        categoria_id = find_foreign_key_from_original('CATEGORIA', object[:categoria], 0)
        sql = "INSERT INTO dbo.RECURSO_MATERIAL (original_id, nombre, tipo, categoria) VALUES (#{object[:id]}, '#{object[:nombre]}', #{tipo_id}, #{categoria_id});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == DetalleProveedoresEquipos && @new
        id_material = find_foreign_key_from_original('RECURSO_MATERIAL', object[:id_Equipo], 0)
        id_proveedor = find_foreign_key_from_original('PROVEEDOR', object[:id_Proveedor], 0)
        sql = "INSERT INTO dbo.PROVEEDOR_MATERIAL (costo, minimo, id_recursomaterial, id_proveedor) VALUES (#{object[:costo_Menudeo]}, 1, #{id_material}, #{id_proveedor});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == MaterialesProveedores && @new
        id_material = find_foreign_key_from_original('RECURSO_MATERIAL', object[:recurso_material], 1)
        id_proveedor = find_foreign_key_from_original('PROVEEDOR', object[:proveedor], 1)
        sql = "INSERT INTO dbo.PROVEEDOR_MATERIAL (costo, minimo, id_recursomaterial, id_proveedor) VALUES (#{object[:costo]}, #{object[:minimo]}, #{id_material}, #{id_proveedor});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == DetalleProveedoresEquipos && !@new
        id_material = find_foreign_key_from_original('RECURSO_MATERIAL', object[:id_recursomaterial], 0)
        id_proveedor = find_foreign_key_from_original('PROVEEDOR', object[:id_proveedor], 0)
        sql = "INSERT INTO dbo.PROVEEDOR_MATERIAL (costo, minimo, id_recursomaterial, id_proveedor) VALUES (#{object[:costo_Menudeo]}, 1, #{id_material}, #{id_proveedor});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == MaterialesProveedores && !@new
        id_material = find_foreign_key_from_original('RECURSO_MATERIAL', object[:id_recursomaterial], 1)
        id_proveedor = find_foreign_key_from_original('PROVEEDOR', object[:id_proveedor], 1)
        sql = "INSERT INTO dbo.PROVEEDOR_MATERIAL (costo, minimo, id_recursomaterial, id_proveedor) VALUES (#{object[:costo]}, #{object[:minimo]}, #{id_material}, #{id_proveedor});"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == SolicitudesCompras && @new
        id_empleado = find_foreign_key('E', 'solicitudes_compras', 'id_Empleado', 'empleado_estacionamientos', 'id', 'curp', 'id_Empleado', object[:id_Empleado], 'dbo.EMPLEADOS', 'curp')
        id_proveedor = find_foreign_key_from_original('PROVEEDOR', object[:id_Proveedor], 0)
        sql = "INSERT INTO dbo.SOLICITUD_COMPRA (cantidad_total, fechaemision, costototal, id_empleado, id_proveedor, original_id) VALUES (#{object[:cantidad_Total]}, '#{object[:fecha_Emision]}', #{object[:costo_Total]}, #{id_empleado}, #{id_proveedor}, #{object[:id_Solicitud]} );"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == SolicitudesCompraMyl && @new
        id_empleado = find_foreign_key('MYL', 'solicitudes_compra_myls', 'persona', 'personas', 'id', 'curp', 'persona', object[:persona], 'dbo.EMPLEADOS', 'curp')
        id_proveedor = find_foreign_key_from_original('PROVEEDOR', object[:proveedor], 1)
        sql = "INSERT INTO dbo.SOLICITUD_COMPRA (cantidad_total, fechaemision, costototal, id_empleado, id_proveedor, original_id) VALUES (#{object[:cantidad_total]}, '#{object[:fecha_emision]}', #{object[:costo_total]}, #{id_empleado}, #{id_proveedor}, #{object[:id]} );"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == SolicitudesCompras && !@new
        id_empleado = find_foreign_key('E', 'solicitudes_compras', 'id_Empleado', 'empleado_estacionamientos', 'id', 'curp', 'id_Empleado', object[:id_empleado], 'dbo.EMPLEADOS', 'curp')
        id_proveedor = find_foreign_key_from_original('PROVEEDOR', object[:id_proveedor], 0)
        sql = "INSERT INTO dbo.SOLICITUD_COMPRA (cantidad_total, fechaemision, costototal, id_empleado, id_proveedor, original_id) VALUES (#{object[:cantidad_total]}, '#{object[:fechaemision]}', #{object[:costototal]}, #{id_empleado}, #{id_proveedor}, #{object[:original_id]} );"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == SolicitudesCompraMyl && !@new
        id_empleado = find_foreign_key('MYL', 'solicitudes_compra_myls', 'persona', 'personas', 'id', 'curp', 'persona', object[:id_empleado], 'dbo.EMPLEADOS', 'curp')
        id_proveedor = find_foreign_key_from_original('PROVEEDOR', object[:id_proveedor], 1)
        sql = "INSERT INTO dbo.SOLICITUD_COMPRA (cantidad_total, fechaemision, costototal, id_empleado, id_proveedor, original_id) VALUES (#{object[:cantidad_total]}, '#{object[:fechaemision]}', #{object[:costototal]}, #{id_empleado}, #{id_proveedor}, #{object[:original_id]} );"
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Servicio && @new
        sql = "INSERT INTO dbo.SERVICIO (nombre, duracion, tipo_servicio) VALUES ('#{object[:nombre]}', #{object[:duracion]}, #{object[:tipo_servicio]} );"
        ActiveRecord::Base.connection.execute(sql)
      end
    end
  end

  def self.save_on_TEMP(object, s, k)
    if @new
      Octopus.using(:TEMP) do
        if k == TipoEmpleado || k == Puesto
          sql = "INSERT INTO dbo.TIPO_EMPLEADOS (nombre, sistema) VALUES ('#{object.nombre}', '#{s}')"
          ActiveRecord::Base.connection.execute(sql)
        end
        if k == Empleado && s == 'E'
          sql = "INSERT INTO dbo.EMPLEADOS (nombre, curp, id_tipoempleado, sistema) VALUES ('#{object[:nombre]}', '#{object[:curp]}', #{object[:id_tipoEmpleado]}, '#{s}')"
          ActiveRecord::Base.connection.execute(sql)
        end
        if k == Persona && s == 'M'
          sql = "INSERT INTO dbo.EMPLEADOS (nombre, curp, id_tipoempleado, sistema) VALUES ('#{object[:nombre]}', '#{object[:curp]}', #{object[:puesto]}, '#{s}')"
          ActiveRecord::Base.connection.execute(sql)
        end
        if k == Empleado && s == 'F'
          sql = "INSERT INTO dbo.EMPLEADOS (nombre, curp, id_tipoempleado, sistema) VALUES ('#{object[:nombre]}', '#{object[:CURP]}', #{object[:id_tipoempleado]}, '#{s}')"
          ActiveRecord::Base.connection.execute(sql)
        end
        if k == Tarjeta
          sql = "INSERT INTO dbo.TARJETA (id_original, estado) VALUES (#{object[:id]}, '#{object[:estado]}');"
          ActiveRecord::Base.connection.execute(sql)
        end
        if k == Estancia
          sql = "INSERT INTO dbo.ESTANCIA (original_id, fechainicio, fechafin, horainicio, horafin, duracion, estado, subtotal, total) VALUES (#{object[:id]}, '#{object[:fecha_Inicio]}', '#{object[:fecha_Fin]}', '#{object[:hora_Inicio].strftime('%H:%M:%S')}', '#{object[:hora_Fin].strftime('%H:%M:%S')}', #{object[:duracion]}, '#{object[:estado]}', #{object[:subtotal]}, #{object[:total]});"
          ActiveRecord::Base.connection.execute(sql)
        end
        if k == DetalleEstanciaVideocamara
          sql = "INSERT INTO dbo.DETALLE_ESTANCIA_VIDEOCAMARAS (placa, id_Estancia) VALUES (#{object[:placa]}, '#{object[:id_Estancia]}');"
          ActiveRecord::Base.connection.execute(sql)
        end
        if k == TipoArea
          sql = "INSERT INTO dbo.TIPO_AREA (original_id, nombre, sistema) VALUES (#{object[:id]}, '#{object[:nombre]}', '#{s}')"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == AreaEstacionamiento
          sql = "INSERT INTO dbo.AREA (original_id, nombre, descripcion, sistema) VALUES (#{object[:id]}, '#{object[:nombre]}', '#{object[:descripcion]}', '#{s}');"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == Area
          sql = "INSERT INTO dbo.AREA (original_id, nombre, sistema, id_tipoarea) VALUES (#{object[:id]}, '#{object[:nombre]}', '#{s}', #{object[:tipo_area]});"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == Cajero
          sql = "INSERT INTO dbo.CAJERO (original_id, dineroactual, fechaactual, periodicidadmantenimiento, estado, id_area) VALUES (#{object[:id]}, #{object[:dinero_Actual]}, '#{object[:fecha_Instalacion]}', '#{object[:periodicidad_Mantenimiento]}', '#{object[:estado]}', #{object[:id_Area]});"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == DetalleTarjetaCajero
          estancia = find_foreign_key_from_attr('E','estancia', 'id_Tarjeta', object[:id_Tarjeta])
          estancia = find_foreign_key_from_original('ESTANCIA', estancia, 0)
          hora = Time.new(object[:fecha].year, object[:fecha].month, object[:fecha].day, object[:hora].strftime('%H'), object[:hora].strftime('%M'), object[:hora].strftime('%S')).strftime('%Y-%m-%d %H:%M:%S')
          sql = "INSERT INTO dbo.ESTANCIA_CAJERO (tarifa, fechainicio, fechafin, id_estancia) VALUES (#{object[:id_Tarifa]}, '#{hora}', '#{hora}', #{estancia});"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == Pasillo
          sql = "INSERT INTO dbo.PASILLO (original_id, numero, cantidad_ocupados, cantidad_libres, id_area) VALUES (#{object[:id]}, #{object[:numero]}, #{object[:cantidad_ocupados]}, '#{object[:cantidad_libres]}', '#{object[:id_Area]}');"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == Sensor
          fecha = Time.new(object[:fecha].year, object[:fecha].month, object[:fecha].day, object[:hora].strftime('%H'), object[:hora].strftime('%M'), object[:hora].strftime('%S')).strftime('%Y-%m-%d %H:%M:%S')
          sql = "INSERT INTO dbo.SENSOR (estado, fecha, id_pasillo) VALUES ('#{object[:estado]}', '#{fecha}', #{object[:id_pasillo]});"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == HorarioDisponible
          sql = "INSERT INTO dbo.HORARIO_DISPONIBLE (original_id, horainicio, horafin, dia) VALUES (#{object[:id]}, '#{object[:hora_inicio].strftime('%H:%M')}', '#{object[:hora_fin].strftime('%H:%M')}', '#{object[:dia]}');"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == DetalleHorarioDisponibleArea
          sql = "INSERT INTO dbo.AREA_HORARIODISPONIBLE (id_horariodisponible, id_area) VALUES (#{object[:horario_disp]}, #{object[:area]});"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == Locale
          sql = "INSERT INTO dbo.LOCALES (numero, original_id, ubicacion, dimensiones, estado, costo) VALUES (#{object[:numero]}, #{object[:numero]}, '#{object[:ubicacion]}', '#{object[:dimensiones]}', '#{object[:estado]}',  #{object[:costo]});"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == Negocio
          sql = "INSERT INTO dbo.NEGOCIOS (nombre, giro, estado, id_locales, original_id) VALUES ('#{object[:nombre]}', '#{object[:giro]}', '#{object[:estado]}', #{object[:id]},  #{object[:id]});"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == Descuento
          negocio = find_foreign_key_from_attr('DTWH', 'NEGOCIOS', 'nombre', object[:nombreNegocio])
          estancia = find_foreign_key_from_original('ESTANCIA', object[:id_Estancia], 0)
          sql = "INSERT INTO dbo.DESCUENTO (cantidad, id_negocio, id_estancia) VALUES (#{object[:cantidad]}, #{negocio},  #{estancia});"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == TiposAccidente
          sql = "INSERT INTO dbo.TIPO_ACCIDENTE (nombre, original_id, sistema) VALUES ('#{object[:nombre]}', #{object[:id_tipoAccidente]}, '#{s}');"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == Accidente
          fecha = Time.new(object[:fecha].year, object[:fecha].month, object[:fecha].day, object[:hora].strftime('%H'), object[:hora].strftime('%M'), object[:hora].strftime('%S')).strftime('%Y-%m-%d %H:%M:%S')
          sql = "INSERT INTO dbo.ACCIDENTES (fecha, id_tipoaccidente, id_area) VALUES ('#{fecha}', #{object[:id_tipoAccidente]}, #{object[:id_Area]});"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == Cliente && @new
          sql = "INSERT INTO dbo.CLIENTE (nombre, RFC) VALUES ('#{object[:nombres]} #{object[:apellidos]}', '#{object[:rfc]}');"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == Contrato
          sql = "INSERT INTO dbo.CONTRATO (fechainicio, fechafin, costo, id_cliente, id_local) VALUES ('#{object[:fechainicio].to_date}', '#{object[:fechafin].to_date}', #{object[:costo]}, #{object[:id_cliente]}, #{object[:id_local]});"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == Rentas
          sql = "INSERT INTO dbo.RENTAS (fechacobro, statusretraso, statuspagado, id_contrato) VALUES ('#{object[:fechacobro].to_date}', '#{object[:statusretraso]}', '#{object[:statuspago]}', #{object[:id_local]});"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == Proveedores || k == ProveedoresMyl
          sql = "INSERT INTO dbo.PROVEEDOR (nombre, rfc, telefono, direccion, original_id, sistema) VALUES ('#{object[:nombre]}', '#{object[:rfc]}', '#{object[:telefono]}', '#{object[:telefono]}', #{object[:id]}, '#{s}');"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == Categorias
          sql = "INSERT INTO dbo.CATEGORIA (nombre, original_id) VALUES ('#{object[:nombre]}', #{object[:id]});"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == TiposEquipo || k == TiposMateriales
          sql = "INSERT INTO dbo.TIPO_MATERIAL (nombre, original_id) VALUES ('#{object[:nombre]}', #{object[:id]});"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == Equipos
          sql = "INSERT INTO dbo.RECURSO_MATERIAL (nombre, tipo, sistema, original_id) VALUES ('#{object[:nombre]}', #{object[:id_tipoEquipo]}, '#{s}', #{object[:id]});"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == RecursosMateriales
          sql = "INSERT INTO dbo.RECURSO_MATERIAL (nombre, tipo, sistema, categoria, original_id) VALUES ('#{object[:nombre]}', #{object[:tipo]}, '#{s}', #{object[:categoria]}, #{object[:id]});"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == DetalleProveedoresEquipos
          sql = "INSERT INTO dbo.PROVEEDOR_MATERIAL (costo, minimo, id_recursomaterial, id_proveedor, sistema) VALUES (#{object[:costo_Menudeo]}, 1, #{object[:id_Equipo]}, #{object[:id_Proveedor]}, '#{s}');"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == MaterialesProveedores
          sql = "INSERT INTO dbo.PROVEEDOR_MATERIAL (costo, minimo, id_recursomaterial, id_proveedor, sistema) VALUES (#{object[:costo]}, #{object[:minimo]}, #{object[:recurso_material]}, #{object[:proveedor]}, '#{s}');"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == SolicitudesCompras
          sql = "INSERT INTO dbo.SOLICITUD_COMPRA (cantidad_total, fechaemision, costototal, id_empleado, id_proveedor, original_id, sistema) VALUES (#{object[:cantidad_Total]}, '#{object[:fecha_Emision]}', #{object[:costo_Total]}, #{object[:id_Empleado]}, #{object[:id_Proveedor]}, #{object[:id_Solicitud]}, '#{s}' );"
          ActiveRecord::Base.connection.execute(sql)
        end

        if k == SolicitudesCompraMyl
          sql = "INSERT INTO dbo.SOLICITUD_COMPRA (cantidad_total, fechaemision, costototal, id_empleado, id_proveedor, original_id, sistema) VALUES (#{object[:cantidad_total]}, '#{object[:fecha_emision]}', #{object[:costo_total]}, #{object[:persona]}, #{object[:proveedor]}, #{object[:id]}, '#{s}');"
          ActiveRecord::Base.connection.execute(sql)
        end
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

  def self.find_foreign_key(db_1, t1, fk1, t2, fk2, select_atr, where_name, where_val, dtwh_t, dtwh_where_name)
    original_value = ''
    Octopus.using(:"#{db_1}") do
      sql = "SELECT two.#{select_atr} from #{t1} as one inner join #{t2} as two on one.#{fk1} = two.#{fk2} where one.#{where_name} = '#{where_val}' LIMIT 1" if db_1 == 'MYL'
      sql = "SELECT two.#{select_atr} from #{t1} as one inner join #{t2} as two on one.#{fk1} = two.#{fk2} where one.#{where_name} = '#{where_val}'" if db_1 != 'MYL'
      original_value = ActiveRecord::Base.connection.execute(sql)
      original_value = original_value.each[0][0] if db_1 == 'E'
    end
    Octopus.using(:DTWH) do
      sql = "SELECT id from #{dtwh_t} where #{dtwh_where_name} = '#{original_value}'"
      result = ActiveRecord::Base.connection.exec_query(sql).rows
      result = result.present? ? result[0][0] : 'null'
    end
  end

  def self.find_foreign_key_from_original(table, original_id, i)
    Octopus.using(:DTWH) do
      sql = "SELECT id from #{table} where original_id = '#{original_id}'"
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
