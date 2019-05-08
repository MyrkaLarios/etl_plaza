class AbonosTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'ABONOS'

  def valid?(s)
    valid_number?(monto) && valid_date?(fechapago)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.ABONOS SET fechapago = '#{params[:fechapago]}', monto = #{params[:monto]} where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    AbonosTEMP.find(params[:id]).update_wrong
  end
end
