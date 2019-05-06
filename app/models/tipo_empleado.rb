class TipoEmpleado < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_name?(nombre) && valid_salary?(salario)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.TIPO_EMPLEADOS SET nombre = '#{params[:nombre]}', salario = '#{params[:salario]}' where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    TipoEmpleado.find(params[:id]).update_wrong
  end
end
