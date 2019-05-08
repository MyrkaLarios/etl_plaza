class SolicitudCompraTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'SOLICITUD_COMPRA'

  def valid?(s)
    valid_salary?(cantidad_total) &&
    valid_salary?(costototal)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.SOLICITUD_COMPRA SET cantidad_total = #{params[:cantidad_total]}, costototal = #{params[:costototal]} where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    SolicitudCompraTEMP.find(params[:id]).update_wrong
  end
end
