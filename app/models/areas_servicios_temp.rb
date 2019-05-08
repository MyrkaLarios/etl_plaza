class AreasServiciosTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'AREA_SERVICIO'

  def valid?(s)
    valid_number?(periodicidad)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.AREA_SERVICIO SET periodicidad = #{params[:periodicidad]} where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    AreasServiciosTEMP.find(params[:id]).update_wrong
  end
end
