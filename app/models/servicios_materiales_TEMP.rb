class ServiciosMaterialesTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'SERVICIO_MATERIAL'

  def valid?(s)
    valid_salary?(cantidad)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.SERVICIO_MATERIAL SET cantidad = #{params[:cantidad]} where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    ServiciosMaterialesTEMP.find(params[:id]).update_wrong
  end
end
