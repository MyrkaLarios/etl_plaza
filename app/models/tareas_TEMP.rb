class TareasTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'TAREA'

  def valid?(s)
    valid_number?(duracion)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.TAREA SET duracion = #{params[:duracion]} where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    TareasTEMP.find(params[:id]).update_wrong
  end
end
