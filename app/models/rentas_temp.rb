class RentasTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'RENTAS'

  def valid?(s)
    valid_date?(fechacobro) &&
    valid_status_retraso?(statusretraso) &&
    valid_status_pago?(statuspagado)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.RENTAS SET fechacobro = '#{params[:fechacobro]}', statusretraso = '#{params[:statusretraso]}', statuspagado = '#{params[:statuspagado]}' where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    RentasTEMP.find(params[:id]).update_wrong
  end
end
