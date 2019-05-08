class AccidenteTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'ACCIDENTES'

  def valid?(s)
    valid_date?(fecha)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.ACCIDENTES SET fecha = '#{params[:fecha]}' where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    AccidenteTEMP.find(params[:id]).update_wrong
  end
end
