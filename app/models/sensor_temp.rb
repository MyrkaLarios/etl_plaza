class SensorTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'SENSOR'

  def valid?(s)
    valid_estado_cajero?(estado) && valid_date?(fecha)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.SENSOR SET estado = '#{params[:estado]}', fecha = '#{params[:fecha][0...10]}' where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    SensorTEMP.find(params[:id]).update_wrong
  end
end
