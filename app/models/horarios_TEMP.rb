class HorariosTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'HORARIO'

  def valid?(s)
    valid_date?(fechainicio) && valid_date?(fechafin)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.HORARIO SET fechainicio = '#{params[:fechainicio]}', fechafin = '#{params[:fechafin]}' where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    HorariosTEMP.find(params[:id]).update_wrong
  end
end
