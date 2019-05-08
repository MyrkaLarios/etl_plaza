class IngresoEstacionamientoTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'INGRESO_ESTACIONAMIENTO'

  def valid?(s)
    valid_number?(cantidad) && valid_date?(fecha)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.INGRESO_ESTACIONAMIENTO SET fecha = '#{params[:fecha]}', cantidad = #{params[:cantidad]} where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    IngresoEstacionamientoTEMP.find(params[:id]).update_wrong
  end
end
