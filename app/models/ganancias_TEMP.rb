class GananciasTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'GANANCIAS'

  def valid?(s)
    if ingresos.present?
      valid_salary?(ingresos) && valid_date?(fechacorte)
    else
      valid_salary?(egresos) && valid_date?(fechacorte)
    end

  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    if params[:egresos].present?
      sql = "UPDATE dbo.GANANCIAS SET egresos = #{params[:egresos]}, fechacorte = '#{params[:fechacorte]}' where id = #{params[:id]};"
    else
      sql = "UPDATE dbo.GANANCIAS SET ingresos = #{params[:ingresos]}, fechacorte = '#{params[:fechacorte]}' where id = #{params[:id]};"
    end
    ActiveRecord::Base.connection.execute(sql)
    GananciasTEMP.find(params[:id]).update_wrong
  end
end
