class CategoriasTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'CATEGORIA'

  def valid?(s)
    valid_name?(nombre)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.CATEGORIA SET nombre = '#{params[:nombre]}' where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    CategoriasTEMP.find(params[:id]).update_wrong
  end
end
