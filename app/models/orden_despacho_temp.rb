class OrdenDespachoTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'ORDEN_DESPACHO'

  def valid?(s)
    valid_date?(fechaentrega)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.ORDEN_DESPACHO SET fechaentrega = '#{params[:fechaentrega]}' where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    OrdenDespachoTEMP.find(params[:id]).update_wrong
  end
end
