class PagosTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'PAGOS'

  def valid?(s)
    valid_number?(monto) && valid_date?(fecha)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.PAGOS SET fecha = '#{params[:fecha]}', monto = #{params[:monto]} where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    PagosTEMP.find(params[:id]).update_wrong
  end
end
