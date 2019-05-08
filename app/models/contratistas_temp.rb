class ContratistasTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'CONTRATANTE'

  def valid?(s)
    valid_telefono?(numero) && valid_business_name?(nombre)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.CONTRATANTE SET nombre = '#{params[:nombre]}', numero = '#{params[:numero]}' where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    ContratistasTEMP.find(params[:id]).update_wrong
  end
end
