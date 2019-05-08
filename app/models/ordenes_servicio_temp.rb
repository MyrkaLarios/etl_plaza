class OrdenesServicioTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'ORDEN_SERVICIO'

  def valid?(s)
    valid_prioridad?(prioridad.to_s) && valid_date?(fecha)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.ORDEN_SERVICIO SET fecha = '#{params[:fecha]}', prioridad = #{params[:prioridad]} where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    OrdenesServicioTEMP.find(params[:id]).update_wrong
  end
end
