class TareasMaterialesTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'TAREA_MATERIAL'

  def valid?(s)
    valid_salary?(cantidadentregada)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.TAREA_MATERIAL SET cantidadentregada = #{params[:cantidadentregada]} where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    TareasMaterialesTEMP.find(params[:id]).update_wrong
  end
end
