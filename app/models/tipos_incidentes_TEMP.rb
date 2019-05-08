class TiposIncidentesTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'TIPO_INCIDENTE'

  def valid?(s)
    valid_name?(nombre)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.TIPO_INCIDENTE SET nombre = '#{params[:nombre]}' where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    TiposIncidentesTEMP.find(params[:id]).update_wrong
  end
end
