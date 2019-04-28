class Etl
  def self.start
    @new = true
    extract_employee_type_data
    extract_employee_data
    # extract_tarjet_data
    # extract_estancia_data
    extract_tipo_area_data
    extract_area_data
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
          sql = "INSERT INTO dbo.EMPLEADOS (nombre, curp, id_tipoempleado) VALUES ('#{object[:nombre]}', '#{curp}', #{fk.zero? ? 'null' : fk})"
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
        sql = "INSERT INTO dbo.ESTANCIA (orginal_id, fechainicio, fechafin, horainicio, horafin, duracion, estado, subtotal, total) VALUES (#{object[:id]}, '#{object[:fecha_Inicio]}', '#{object[:fecha_Fin]}', '#{object[:hora_Inicio].strftime('%H:%M:%S')}', '#{object[:hora_Fin].strftime('%H:%M:%S')}', #{object[:duracion]}, '#{object[:estado]}', #{object[:subtotal]}, #{object[:total]});"
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
        tipo_area = find_foreign_key_from_original('TIPO_AREA', object[:tipo_area])
        if !already_in_db?('nombre', object[:nombre], 'AREA')
          sql = "INSERT INTO dbo.AREA (original_id, nombre, id_tipoarea) VALUES (#{object[:id]}, '#{object[:nombre]}', #{tipo_area});"
          ActiveRecord::Base.connection.execute(sql)
        end
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
          sql = "INSERT INTO dbo.ESTANCIA (orginal_id, fechainicio, fechafin, horainicio, horafin, duracion, estado, subtotal, total) VALUES (#{object[:id]}, '#{object[:fecha_Inicio]}', '#{object[:fecha_Fin]}', '#{object[:hora_Inicio].strftime('%H:%M:%S')}', '#{object[:hora_Fin].strftime('%H:%M:%S')}', #{object[:duracion]}, '#{object[:estado]}', #{object[:subtotal]}, #{object[:total]});"
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
      sql = "SELECT two.#{select_atr} from #{t1} as one inner join #{t2} as two on one.#{fk1} = two.#{fk2} where one.#{where_name} = '#{where_val}'"
      original_value = ActiveRecord::Base.connection.execute(sql)
      original_value = original_value.each[0][0] if db_1 == 'E'
    end
    Octopus.using(:DTWH) do
      sql = "SELECT id from #{dtwh_t} where #{dtwh_where_name} = '#{original_value}'"
      ActiveRecord::Base.connection.execute(sql)
    end
  end

  def self.find_foreign_key_from_original(table, original_id)
    Octopus.using(:DTWH) do
      sql = "SELECT id from #{table} where original_id = '#{original_id}'"
      result = ActiveRecord::Base.connection.exec_query(sql).rows
      result = result.present? ? result[0][0] : 'null'
    end
  end
end
