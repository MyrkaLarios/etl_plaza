class ClienteTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'CLIENTE'

  def valid?(s)
    valid_RFC?(self.RFC) && valid_name?("#{nombre}")
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.CLIENTE SET RFC = '#{params[:RFC]}', nombre = '#{params[:nombre]}' where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    ClienteTEMP.find(params[:id]).update_wrong
  end
end
