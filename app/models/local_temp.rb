class LocalTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'LOCALES'

  def valid?(s)
    valid_dimension?(dimensiones) && valid_salary?(costo.to_i) && valid_estado_local?(estado)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.LOCALES SET dimensiones = '#{params[:dimensiones]}', estado = '#{params[:estado]}', costo = #{params[:costo]} where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    LocalTEMP.find(params[:id]).update_wrong
  end
end
