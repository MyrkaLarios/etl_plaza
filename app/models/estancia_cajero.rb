class EstanciaCajero < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'ESTANCIA_CAJERO'

  def valid?(s)
    valid_date?(fechainicio) && valid_date?(fechafin) && valid_number?(tarifa)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.ESTANCIA_CAJERO SET fechainicio = '#{params[:fechafin]}', fechafin = '#{params[:fechafin]}', tarifa = #{params[:tarifa]} where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    EstanciaCajero.find(params[:id]).update_wrong
  end
end
