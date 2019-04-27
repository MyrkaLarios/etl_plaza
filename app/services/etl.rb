class Etl
  def self.start
    extract_employee_type_data
    extract_employee_data
    # extract_data_from_RF
  end

  def self.extract_employee_type_data
    Octopus.using(:E) do
      send_to_DWH(TipoEmpleado.all, 'E')
    end
    Octopus.using(:MYL) do
      send_to_DWH(Puesto.all, 'M')
    end
    Octopus.using(:RF) do
      send_to_DWH(TipoEmpleado.all, 'R')
    end
  end

  def self.extract_employee_data
    Octopus.using(:RF) do
      send_to_DWH(Empleado.all, 'F')
    end
    Octopus.using(:E) do
      send_to_DWH(Empleado.all, 'E')
    end
    Octopus.using(:MYL) do
      send_to_DWH(Persona.all, 'M')
    end

  end

  def self.extract_data_from_RF
  end

  def self.send_to_DWH(objects, s)
    objects.each do |object|
      object.valid?(s) ? save_on_DTWH(object, object.class, s) : save_on_TEMP(object, s, object.class)
    end
  end

  def self.save_on_DTWH(object, k, s)
    Octopus.using(:DTWH) do
      if k == TipoEmpleado || k == Puesto
        if already_in_db?('nombre', object[:nombre], 'dbo.TIPOS_EMPLEADO')
          sql = "UPDATE dbo.TIPOS_EMPLEADO SET salario = #{object[:salario] ? object[:salario] : 0} WHERE nombre = '#{object[:nombre]}'"
        else
          sql = "INSERT INTO dbo.TIPOS_EMPLEADO (nombre, salario) VALUES ('#{object[:nombre]}', #{object[:salario] ? object[:salario] : 0})"
        end
        ActiveRecord::Base.connection.execute(sql)
      end

      if k == Empleado || k == Persona
        fk = find_foreign_key('E', 'empleados', 'id_tipoEmpleado', 'tipo_empleados', 'id_tipoEmpleado', 'nombre', 'curp', object[:curp], 'dbo.TIPOS_EMPLEADO', 'nombre') if s == 'E'
        fk = find_foreign_key('MYL', 'personas', 'puesto', 'puestos', 'id', 'nombre', 'curp', object[:curp], 'dbo.TIPOS_EMPLEADO', 'nombre') if s == 'M'
        fk = find_foreign_key('RF', 'empleados', 'id_tipoempleado', 'tipo_empleados', 'Id', 'nombre', 'curp', object[:CURP], 'dbo.TIPOS_EMPLEADO', 'nombre') if s == 'F'
        if already_in_db?('curp', "#{object[:curp] ? object[:curp] : object[:CURP]}", 'dbo.EMPLEADOS')
          sql = "UPDATE dbo.EMPLEADOS SET id_tipoempleado = #{fk} WHERE curp = '#{object[:curp] ? object[:curp] : object[:CURP]}'"
        else
          sql = "INSERT INTO dbo.EMPLEADOS (nombre, curp, id_tipoempleado) VALUES ('#{object[:nombre]}', '#{object[:curp] ? object[:curp] : object[:CURP]}', #{fk.zero? ? 'null' : fk})"
          ActiveRecord::Base.connection.execute(sql)
        end
      end
    end
  end

  def self.save_on_TEMP(object, s, k)
    Octopus.using(:TEMP) do
      if k == TipoEmpleado || k == Puesto
        sql = "INSERT INTO dbo.TIPOS_EMPLEADO (nombre, sistema) VALUES ('#{object.nombre}', '#{s}')"
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
end
