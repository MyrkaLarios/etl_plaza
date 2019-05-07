class HorariosDisponiblesTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'HORARIO_DISPONIBLE'

  def valid?(s)
    valid_dia?(dia)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.HORARIO_DISPONIBLE SET dia = '#{params[:dia]}' where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    HorariosDisponiblesTEMP.find(params[:id]).update_wrong
  end
end
