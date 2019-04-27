class Etl
  def self.start
    extract_data_from_E
    extract_data_from_MYL
    extract_data_from_RF
  end

  def self.extract_data_from_E
    Octopus.using(:E) do
      send_to_DWH(TipoEmpleado.all, 'E')
    end
  end

  def self.extract_data_from_MYL
    Octopus.using(:MYL) do
      send_to_DWH(Puesto.all, 'M')
    end
  end

  def self.extract_data_from_RF
    Octopus.using(:RF) do
      send_to_DWH(TipoEmpleado.all, 'R')
    end
  end

  def self.send_to_DWH(objects, s)
    objects.each do |object|
      object.valid?(s) ? save_on_DTWH(object, object.class) : save_on_TEMP(object, s, object.class)
    end

  end

  def self.save_on_DTWH(object, k)
    Octopus.using(:DTWH) do
      if k == TipoEmpleado || k == Puesto
        if already_in_db?('nombre', object[:nombre], 'dbo.TIPOS_EMPLEADO')
          sql = "UPDATE dbo.TIPOS_EMPLEADO SET salario = #{object[:salario] ? object[:salario] : 0} WHERE nombre = '#{object[:nombre]}'"
        else
          sql = "INSERT INTO dbo.TIPOS_EMPLEADO (nombre, salario) VALUES ('#{object[:nombre]}', #{object[:salario] ? object[:salario] : 0})"
        end
        ActiveRecord::Base.connection.execute(sql)
      end
    end
  end

  def self.save_on_TEMP(object, s, k)
    Octopus.using(:TEMP) do
      if k == TipoEmpleado || k == Puesto
        sql = "INSERT INTO dbo.TIPOS_EMPLEADO (nombre, sistema) VALUES ('#{object.nombre}', '#{s}')"
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
end
