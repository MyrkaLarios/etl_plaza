class GananciasTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'GANANCIAS'

  def valid?(s)
    valid_number?(ingresos) && valid_number?(egresos) && valid_date?(fechacorte) && (ingresos != 0 || egresos != 0)
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
