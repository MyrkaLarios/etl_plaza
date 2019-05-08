




# if k == DetalleTarjetaCajero && !@new
#   sql = "INSERT INTO dbo.ESTANCIA_CAJERO (tarifa, fechainicio, fechafin, id_estancia) VALUES (#{object[:tarifa]}, #{object[:fechainicio]}, '#{object[:fechafin]}', '#{object[:id_estancia]}');"
#   ActiveRecord::Base.connection.execute(sql)
# end


# if k == Sensor && !@new
#   sql = "INSERT INTO dbo.SENSOR (estado, fecha, id_pasillo) VALUES ('#{object[:estado]}', '#{object[:fecha]}', #{pasillo});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == HorarioDisponible
#   sql = "INSERT INTO dbo.HORARIO_DISPONIBLE (original_id, horainicio, horafin, dia) VALUES (#{object[:id]}, '#{object[:hora_inicio].strftime('%H:%M')}', '#{object[:hora_fin].strftime('%H:%M')}', '#{object[:dia]}');"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == DetalleHorarioDisponibleArea
#   area = find_foreign_key_from_original('AREA', object[:area], 0)
#   horario = find_foreign_key_from_original('HORARIO_DISPONIBLE', object[:horario_disp],0)
#   sql = "INSERT INTO dbo.AREA_HORARIODISPONIBLE (id_horariodisponible, id_area) VALUES (#{horario}, #{area});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == Locale
#   ubicacion = find_foreign_key_from_attr('DTWH','AREA', 'nombre', object[:ubicacion])
#   sql = "INSERT INTO dbo.LOCALES (numero, original_id, ubicacion, dimensiones, estado, costo) VALUES (#{object[:numero]}, #{object[:numero]}, '#{ubicacion}', '#{object[:dimensiones]}', '#{object[:estado]}',  #{object[:costo]});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == Negocio
#   local = find_foreign_key_from_original('LOCALES', object[:id_locales],0)
#   sql = "INSERT INTO dbo.NEGOCIOS (nombre, giro, estado, id_locales, original_id) VALUES ('#{object[:nombre]}', '#{object[:giro]}', '#{object[:estado]}', #{local},  #{object[:id]});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == LocalNegocio
#   local = find_foreign_key_from_original('LOCALES', object[:id_local], 0)
#   negocio = find_foreign_key_from_original('NEGOCIOS', object[:id_negocio], 0)
#   sql = "INSERT INTO dbo.LOCAL_NEGOCIO (fechainicio, fechafin, id_negocio, id_locales) VALUES ('#{object[:fechaini].strftime('%Y-%m-%d')}', '#{object[:fechafin].strftime('%Y-%m-%d')}', #{negocio},  #{local});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == Descuento && @new
#   negocio = find_foreign_key_from_attr('DTWH', 'NEGOCIOS', 'nombre', object[:nombreNegocio])
#   estancia = find_foreign_key_from_original('ESTANCIA', object[:id_Estancia], 0)
#   sql = "INSERT INTO dbo.DESCUENTO (cantidad, id_negocio, id_estancia) VALUES (#{object[:cantidad]}, #{negocio},  #{estancia});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == Descuento && !@new
#   sql = "INSERT INTO dbo.DESCUENTO (cantidad, id_negocio, id_estancia) VALUES (#{object[:cantidad]}, #{object[:id_negocio]},  #{object[:id_estancia]});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == TiposAccidente && @new
#   sql = "INSERT INTO dbo.TIPO_ACCIDENTE (nombre, original_id) VALUES ('#{object[:nombre]}', #{object[:id_tipoAccidente]});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == TiposAccidente && !@new
#   sql = "INSERT INTO dbo.TIPO_ACCIDENTE (nombre, original_id) VALUES ('#{object[:nombre]}', #{object[:original_id]});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == Accidente && @new
#   fecha = Time.new(object[:fecha].year, object[:fecha].month, object[:fecha].day, object[:hora].strftime('%H'), object[:hora].strftime('%M'), object[:hora].strftime('%S')).strftime('%Y-%m-%d %H:%M:%S')
#   tipo_a = find_foreign_key_from_original('TIPO_ACCIDENTE', object[:id_tipoAccidente], 0)
#   area = find_foreign_key_from_original('AREA', object[:id_Area], 1)
#   sql = "INSERT INTO dbo.ACCIDENTES (fecha, id_tipoaccidente, id_area) VALUES ('#{fecha}', #{tipo_a}, #{area});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == Accidente && !@new
#   tipo_a = find_foreign_key_from_original('TIPO_ACCIDENTE', object[:id_tipoaccidente], 0)
#   area = find_foreign_key_from_original('AREA', object[:id_area], 1)
#   sql = "INSERT INTO dbo.ACCIDENTES (fecha, id_tipoaccidente, id_area) VALUES ('#{object[:fecha]}', #{tipo_a}, #{area});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == Cliente && @new
#   sql = "INSERT INTO dbo.CLIENTE (nombre, RFC) VALUES ('#{object[:nombres]} #{object[:apellidos]}', '#{object[:rfc]}');"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == Cliente && !@new
#   sql = "INSERT INTO dbo.CLIENTE (nombre, RFC) VALUES ('#{object[:nombre]}', '#{object[:RFC]}');"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == Contrato
#   sql = "INSERT INTO dbo.CONTRATO (fechainicio, fechafin, costo, id_cliente, id_local, original_id) VALUES ('#{object[:fechainicio].to_date}', '#{object[:fechafin].to_date}', #{object[:costo]}, #{object[:id_cliente]}, #{object[:id_local]}, #{object[:id]});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == Rentas && @new
#   contrato = find_foreign_key_from_attr('DTWH', 'contrato', 'id_local', object[:id_local].to_i)
#   sql = "INSERT INTO dbo.RENTAS (fechacobro, statusretraso, statuspagado, id_contrato) VALUES ('#{object[:fechacobro].to_date}', '#{object[:statusretraso]}', '#{object[:statuspago]}', #{contrato});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == Rentas && !@new
#   contrato = find_foreign_key_from_attr('DTWH', 'contrato', 'id_local', object[:id_local].to_i)
#   sql = "INSERT INTO dbo.RENTAS (fechacobro, statusretraso, statuspagado, id_contrato) VALUES ('#{object[:fechacobro].to_date}', '#{object[:statusretraso]}', '#{object[:statuspagado]}', #{contrato});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if (k == Proveedores || k == ProveedoresMyl) && @new
#   sql = "INSERT INTO dbo.RENTAS (nombre, rfc, telefono, direccion, original_id) VALUES ('#{object[:nombre]}', '#{object[:rfc]}', '#{object[:telefono]}', '#{object[:telefono]}', #{object[:id]});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if (k == Proveedores || k == ProveedoresMyl) && !@new
#   sql = "INSERT INTO dbo.PROVEEDOR (nombre, rfc, telefono, direccion, original_id) VALUES ('#{object[:nombre]}', '#{object[:rfc]}', '#{object[:telefono]}', '#{object[:telefono]}', #{object[:original_id]});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == Categorias && @new
#   sql = "INSERT INTO dbo.CATEGORIA (nombre, original_id) VALUES ('#{object[:nombre]}', #{object[:id]});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == Categorias && !@new
#   sql = "INSERT INTO dbo.CATEGORIA (nombre, original_id) VALUES ('#{object[:nombre]}', #{object[:original_id]});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if (k == TiposEquipo || k == TiposMateriales) && @new
#   sql = "INSERT INTO dbo.TIPO_MATERIAL (nombre, original_id) VALUES ('#{object[:nombre]}', #{object[:id]});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if (k == TiposEquipo || k == TiposMateriales) && !@new
#   sql = "INSERT INTO dbo.TIPO_MATERIAL (nombre, original_id) VALUES ('#{object[:nombre]}', #{object[:original_id]});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == Equipos && @new
#   tipo_id = find_foreign_key_from_original('TIPO_MATERIAL', object[:id_tipoEquipo], 0)
#   sql = "INSERT INTO dbo.RECURSO_MATERIAL (original_id, nombre, tipo) VALUES (#{object[:id]}, '#{object[:nombre]}', #{tipo_id});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == RecursosMateriales && @new
#   tipo_id = find_foreign_key_from_original('TIPO_MATERIAL', object[:tipo], 1)
#   categoria_id = find_foreign_key_from_original('CATEGORIA', object[:categoria], 0)
#   sql = "INSERT INTO dbo.RECURSO_MATERIAL (original_id, nombre, tipo, categoria) VALUES (#{object[:id]}, '#{object[:nombre]}', #{tipo_id}, #{categoria_id});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == Equipos && !@new
#   tipo_id = find_foreign_key_from_original('TIPO_MATERIAL', object[:tipo], 0)
#   sql = "INSERT INTO dbo.RECURSO_MATERIAL (original_id, nombre, tipo) VALUES (#{object[:id]}, '#{object[:nombre]}', #{tipo_id});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == RecursosMateriales && !@new
#   tipo_id = find_foreign_key_from_original('TIPO_MATERIAL', object[:tipo], 1)
#   categoria_id = find_foreign_key_from_original('CATEGORIA', object[:categoria], 0)
#   sql = "INSERT INTO dbo.RECURSO_MATERIAL (original_id, nombre, tipo, categoria) VALUES (#{object[:id]}, '#{object[:nombre]}', #{tipo_id}, #{categoria_id});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == DetalleProveedoresEquipos && @new
#   id_material = find_foreign_key_from_original('RECURSO_MATERIAL', object[:id_Equipo], 0)
#   id_proveedor = find_foreign_key_from_original('PROVEEDOR', object[:id_Proveedor], 0)
#   sql = "INSERT INTO dbo.PROVEEDOR_MATERIAL (costo, minimo, id_recursomaterial, id_proveedor) VALUES (#{object[:costo_Menudeo]}, 1, #{id_material}, #{id_proveedor});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == MaterialesProveedores && @new
#   id_material = find_foreign_key_from_original('RECURSO_MATERIAL', object[:recurso_material], 1)
#   id_proveedor = find_foreign_key_from_original('PROVEEDOR', object[:proveedor], 1)
#   sql = "INSERT INTO dbo.PROVEEDOR_MATERIAL (costo, minimo, id_recursomaterial, id_proveedor) VALUES (#{object[:costo]}, #{object[:minimo]}, #{id_material}, #{id_proveedor});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == DetalleProveedoresEquipos && !@new
#   id_material = find_foreign_key_from_original('RECURSO_MATERIAL', object[:id_recursomaterial], 0)
#   id_proveedor = find_foreign_key_from_original('PROVEEDOR', object[:id_proveedor], 0)
#   sql = "INSERT INTO dbo.PROVEEDOR_MATERIAL (costo, minimo, id_recursomaterial, id_proveedor) VALUES (#{object[:costo_Menudeo]}, 1, #{id_material}, #{id_proveedor});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == MaterialesProveedores && !@new
#   id_material = find_foreign_key_from_original('RECURSO_MATERIAL', object[:id_recursomaterial], 1)
#   id_proveedor = find_foreign_key_from_original('PROVEEDOR', object[:id_proveedor], 1)
#   sql = "INSERT INTO dbo.PROVEEDOR_MATERIAL (costo, minimo, id_recursomaterial, id_proveedor) VALUES (#{object[:costo]}, #{object[:minimo]}, #{id_material}, #{id_proveedor});"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == SolicitudesCompras && @new
#   id_empleado = find_foreign_key('E', 'solicitudes_compras', 'id_Empleado', 'empleado_estacionamientos', 'id', 'curp', 'id_Empleado', object[:id_Empleado], 'dbo.EMPLEADOS', 'curp')
#   id_proveedor = find_foreign_key_from_original('PROVEEDOR', object[:id_Proveedor], 0)
#   sql = "INSERT INTO dbo.SOLICITUD_COMPRA (cantidad_total, fechaemision, costototal, id_empleado, id_proveedor, original_id) VALUES (#{object[:cantidad_Total]}, '#{object[:fecha_Emision]}', #{object[:costo_Total]}, #{id_empleado}, #{id_proveedor}, #{object[:id_Solicitud]} );"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == SolicitudesCompraMyl && @new
#   id_empleado = find_foreign_key('MYL', 'solicitudes_compra_myls', 'persona', 'personas', 'id', 'curp', 'persona', object[:persona], 'dbo.EMPLEADOS', 'curp')
#   id_proveedor = find_foreign_key_from_original('PROVEEDOR', object[:proveedor], 1)
#   sql = "INSERT INTO dbo.SOLICITUD_COMPRA (cantidad_total, fechaemision, costototal, id_empleado, id_proveedor, original_id) VALUES (#{object[:cantidad_total]}, '#{object[:fecha_emision]}', #{object[:costo_total]}, #{id_empleado}, #{id_proveedor}, #{object[:id]} );"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == SolicitudesCompras && !@new
#   id_empleado = find_foreign_key('E', 'solicitudes_compras', 'id_Empleado', 'empleado_estacionamientos', 'id', 'curp', 'id_Empleado', object[:id_empleado], 'dbo.EMPLEADOS', 'curp')
#   id_proveedor = find_foreign_key_from_original('PROVEEDOR', object[:id_proveedor], 0)
#   sql = "INSERT INTO dbo.SOLICITUD_COMPRA (cantidad_total, fechaemision, costototal, id_empleado, id_proveedor, original_id) VALUES (#{object[:cantidad_total]}, '#{object[:fechaemision]}', #{object[:costototal]}, #{id_empleado}, #{id_proveedor}, #{object[:original_id]} );"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == SolicitudesCompraMyl && !@new
#   id_empleado = find_foreign_key('MYL', 'solicitudes_compra_myls', 'persona', 'personas', 'id', 'curp', 'persona', object[:id_empleado], 'dbo.EMPLEADOS', 'curp')
#   id_proveedor = find_foreign_key_from_original('PROVEEDOR', object[:id_proveedor], 1)
#   sql = "INSERT INTO dbo.SOLICITUD_COMPRA (cantidad_total, fechaemision, costototal, id_empleado, id_proveedor, original_id) VALUES (#{object[:cantidad_total]}, '#{object[:fechaemision]}', #{object[:costototal]}, #{id_empleado}, #{id_proveedor}, #{object[:original_id]} );"
#   ActiveRecord::Base.connection.execute(sql)
# end

# if k == Servicio && @new
#   sql = "INSERT INTO dbo.SERVICIO (nombre, duracion, tipo_servicio) VALUES ('#{object[:nombre]}', #{object[:duracion]}, #{object[:tipo_servicio]} );"
#   ActiveRecord::Base.connection.execute(sql)
# end
# end
# end

# def self.save_on_TEMP(object, s, k)
# if @new
# Octopus.using(:TEMP) do
#   if k == TipoEmpleado || k == Puesto
#     sql = "INSERT INTO dbo.TIPO_EMPLEADOS (nombre, sistema) VALUES ('#{object.nombre}', '#{s}')"
#     ActiveRecord::Base.connection.execute(sql)
#   end
#   if k == Empleado && s == 'E'
#     sql = "INSERT INTO dbo.EMPLEADOS (nombre, curp, id_tipoempleado, sistema) VALUES ('#{object[:nombre]}', '#{object[:curp]}', #{object[:id_tipoEmpleado]}, '#{s}')"
#     ActiveRecord::Base.connection.execute(sql)
#   end
#   if k == Persona && s == 'M'
#     sql = "INSERT INTO dbo.EMPLEADOS (nombre, curp, id_tipoempleado, sistema) VALUES ('#{object[:nombre]}', '#{object[:curp]}', #{object[:puesto]}, '#{s}')"
#     ActiveRecord::Base.connection.execute(sql)
#   end
#   if k == Empleado && s == 'F'
#     sql = "INSERT INTO dbo.EMPLEADOS (nombre, curp, id_tipoempleado, sistema) VALUES ('#{object[:nombre]}', '#{object[:CURP]}', #{object[:id_tipoempleado]}, '#{s}')"
#     ActiveRecord::Base.connection.execute(sql)
#   end
#   if k == Tarjeta
#     sql = "INSERT INTO dbo.TARJETA (id_original, estado) VALUES (#{object[:id]}, '#{object[:estado]}');"
#     ActiveRecord::Base.connection.execute(sql)
#   end
#   if k == Estancia
#     sql = "INSERT INTO dbo.ESTANCIA (original_id, fechainicio, fechafin, horainicio, horafin, duracion, estado, subtotal, total) VALUES (#{object[:id]}, '#{object[:fecha_Inicio]}', '#{object[:fecha_Fin]}', '#{object[:hora_Inicio].strftime('%H:%M:%S')}', '#{object[:hora_Fin].strftime('%H:%M:%S')}', #{object[:duracion]}, '#{object[:estado]}', #{object[:subtotal]}, #{object[:total]});"
#     ActiveRecord::Base.connection.execute(sql)
#   end
#   if k == DetalleEstanciaVideocamara
#     sql = "INSERT INTO dbo.DETALLE_ESTANCIA_VIDEOCAMARAS (placa, id_Estancia) VALUES (#{object[:placa]}, '#{object[:id_Estancia]}');"
#     ActiveRecord::Base.connection.execute(sql)
#   end
#   if k == TipoArea
#     sql = "INSERT INTO dbo.TIPO_AREA (original_id, nombre, sistema) VALUES (#{object[:id]}, '#{object[:nombre]}', '#{s}')"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == AreaEstacionamiento
#     sql = "INSERT INTO dbo.AREA (original_id, nombre, descripcion, sistema) VALUES (#{object[:id]}, '#{object[:nombre]}', '#{object[:descripcion]}', '#{s}');"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == Area
#     sql = "INSERT INTO dbo.AREA (original_id, nombre, sistema, id_tipoarea) VALUES (#{object[:id]}, '#{object[:nombre]}', '#{s}', #{object[:tipo_area]});"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == Cajero
#     sql = "INSERT INTO dbo.CAJERO (original_id, dineroactual, fechaactual, periodicidadmantenimiento, estado, id_area) VALUES (#{object[:id]}, #{object[:dinero_Actual]}, '#{object[:fecha_Instalacion]}', '#{object[:periodicidad_Mantenimiento]}', '#{object[:estado]}', #{object[:id_Area]});"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == DetalleTarjetaCajero
#     estancia = find_foreign_key_from_attr('E','estancia', 'id_Tarjeta', object[:id_Tarjeta])
#     estancia = find_foreign_key_from_original('ESTANCIA', estancia, 0)
#     hora = Time.new(object[:fecha].year, object[:fecha].month, object[:fecha].day, object[:hora].strftime('%H'), object[:hora].strftime('%M'), object[:hora].strftime('%S')).strftime('%Y-%m-%d %H:%M:%S')
#     sql = "INSERT INTO dbo.ESTANCIA_CAJERO (tarifa, fechainicio, fechafin, id_estancia) VALUES (#{object[:id_Tarifa]}, '#{hora}', '#{hora}', #{estancia});"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == Pasillo
#     sql = "INSERT INTO dbo.PASILLO (original_id, numero, cantidad_ocupados, cantidad_libres, id_area) VALUES (#{object[:id]}, #{object[:numero]}, #{object[:cantidad_ocupados]}, '#{object[:cantidad_libres]}', '#{object[:id_Area]}');"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == Sensor
#     fecha = Time.new(object[:fecha].year, object[:fecha].month, object[:fecha].day, object[:hora].strftime('%H'), object[:hora].strftime('%M'), object[:hora].strftime('%S')).strftime('%Y-%m-%d %H:%M:%S')
#     sql = "INSERT INTO dbo.SENSOR (estado, fecha, id_pasillo) VALUES ('#{object[:estado]}', '#{fecha}', #{object[:id_pasillo]});"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == HorarioDisponible
#     sql = "INSERT INTO dbo.HORARIO_DISPONIBLE (original_id, horainicio, horafin, dia) VALUES (#{object[:id]}, '#{object[:hora_inicio].strftime('%H:%M')}', '#{object[:hora_fin].strftime('%H:%M')}', '#{object[:dia]}');"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == DetalleHorarioDisponibleArea
#     sql = "INSERT INTO dbo.AREA_HORARIODISPONIBLE (id_horariodisponible, id_area) VALUES (#{object[:horario_disp]}, #{object[:area]});"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == Locale
#     sql = "INSERT INTO dbo.LOCALES (numero, original_id, ubicacion, dimensiones, estado, costo) VALUES (#{object[:numero]}, #{object[:numero]}, '#{object[:ubicacion]}', '#{object[:dimensiones]}', '#{object[:estado]}',  #{object[:costo]});"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == Negocio
#     sql = "INSERT INTO dbo.NEGOCIOS (nombre, giro, estado, id_locales, original_id) VALUES ('#{object[:nombre]}', '#{object[:giro]}', '#{object[:estado]}', #{object[:id]},  #{object[:id]});"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == Descuento
#     negocio = find_foreign_key_from_attr('DTWH', 'NEGOCIOS', 'nombre', object[:nombreNegocio])
#     estancia = find_foreign_key_from_original('ESTANCIA', object[:id_Estancia], 0)
#     sql = "INSERT INTO dbo.DESCUENTO (cantidad, id_negocio, id_estancia) VALUES (#{object[:cantidad]}, #{negocio},  #{estancia});"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == TiposAccidente
#     sql = "INSERT INTO dbo.TIPO_ACCIDENTE (nombre, original_id, sistema) VALUES ('#{object[:nombre]}', #{object[:id_tipoAccidente]}, '#{s}');"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == Accidente
#     fecha = Time.new(object[:fecha].year, object[:fecha].month, object[:fecha].day, object[:hora].strftime('%H'), object[:hora].strftime('%M'), object[:hora].strftime('%S')).strftime('%Y-%m-%d %H:%M:%S')
#     sql = "INSERT INTO dbo.ACCIDENTES (fecha, id_tipoaccidente, id_area) VALUES ('#{fecha}', #{object[:id_tipoAccidente]}, #{object[:id_Area]});"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == Cliente && @new
#     sql = "INSERT INTO dbo.CLIENTE (nombre, RFC) VALUES ('#{object[:nombres]} #{object[:apellidos]}', '#{object[:rfc]}');"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == Contrato
#     sql = "INSERT INTO dbo.CONTRATO (fechainicio, fechafin, costo, id_cliente, id_local) VALUES ('#{object[:fechainicio].to_date}', '#{object[:fechafin].to_date}', #{object[:costo]}, #{object[:id_cliente]}, #{object[:id_local]});"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == Rentas
#     sql = "INSERT INTO dbo.RENTAS (fechacobro, statusretraso, statuspagado, id_contrato) VALUES ('#{object[:fechacobro].to_date}', '#{object[:statusretraso]}', '#{object[:statuspago]}', #{object[:id_local]});"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == Proveedores || k == ProveedoresMyl
#     sql = "INSERT INTO dbo.PROVEEDOR (nombre, rfc, telefono, direccion, original_id, sistema) VALUES ('#{object[:nombre]}', '#{object[:rfc]}', '#{object[:telefono]}', '#{object[:telefono]}', #{object[:id]}, '#{s}');"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == Categorias
#     sql = "INSERT INTO dbo.CATEGORIA (nombre, original_id) VALUES ('#{object[:nombre]}', #{object[:id]});"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == TiposEquipo || k == TiposMateriales
#     sql = "INSERT INTO dbo.TIPO_MATERIAL (nombre, original_id) VALUES ('#{object[:nombre]}', #{object[:id]});"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == Equipos
#     sql = "INSERT INTO dbo.RECURSO_MATERIAL (nombre, tipo, sistema, original_id) VALUES ('#{object[:nombre]}', #{object[:id_tipoEquipo]}, '#{s}', #{object[:id]});"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == RecursosMateriales
#     sql = "INSERT INTO dbo.RECURSO_MATERIAL (nombre, tipo, sistema, categoria, original_id) VALUES ('#{object[:nombre]}', #{object[:tipo]}, '#{s}', #{object[:categoria]}, #{object[:id]});"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == DetalleProveedoresEquipos
#     sql = "INSERT INTO dbo.PROVEEDOR_MATERIAL (costo, minimo, id_recursomaterial, id_proveedor, sistema) VALUES (#{object[:costo_Menudeo]}, 1, #{object[:id_Equipo]}, #{object[:id_Proveedor]}, '#{s}');"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == MaterialesProveedores
#     sql = "INSERT INTO dbo.PROVEEDOR_MATERIAL (costo, minimo, id_recursomaterial, id_proveedor, sistema) VALUES (#{object[:costo]}, #{object[:minimo]}, #{object[:recurso_material]}, #{object[:proveedor]}, '#{s}');"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == SolicitudesCompras
#     sql = "INSERT INTO dbo.SOLICITUD_COMPRA (cantidad_total, fechaemision, costototal, id_empleado, id_proveedor, original_id, sistema) VALUES (#{object[:cantidad_Total]}, '#{object[:fecha_Emision]}', #{object[:costo_Total]}, #{object[:id_Empleado]}, #{object[:id_Proveedor]}, #{object[:id_Solicitud]}, '#{s}' );"
#     ActiveRecord::Base.connection.execute(sql)
#   end

#   if k == SolicitudesCompraMyl
#     sql = "INSERT INTO dbo.SOLICITUD_COMPRA (cantidad_total, fechaemision, costototal, id_empleado, id_proveedor, original_id, sistema) VALUES (#{object[:cantidad_total]}, '#{object[:fecha_emision]}', #{object[:costo_total]}, #{object[:persona]}, #{object[:proveedor]}, #{object[:id]}, '#{s}');"
#     ActiveRecord::Base.connection.execute(sql)
#   end
# end
# end
# end













