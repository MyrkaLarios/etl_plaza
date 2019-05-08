class IncidentesTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'INCIDENTE'

  def valid?(s)
    valid_date?(fecha)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.INCIDENTE SET fecha = '#{params[:fecha]}' where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    IncidentesTEMP.find(params[:id]).update_wrong
  end
end
