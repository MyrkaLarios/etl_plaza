class EtlController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    if Empleado.all.empty?
      Etl.start
      redirect_to etl_index_path
    else
      Octopus.using(:TEMP) do
        @tipos_empleados = TipoEmpleado.all
        @empleados = Empleado.all
        @tarjetas = TarjetasTEMP.all


      end
    end
  end

  def delete_element
    Octopus.using(:TEMP) do
      sql = "DELETE FROM #{params[:table]} WHERE id = #{params[:id]}"
      ActiveRecord::Base.connection.execute(sql)
    end
    if current_user.user_type == 1
      redirect_to etl_index_path
    else
      redirect_to authenticated_root_path
    end
  end

  def modify_element
    @table = params[:table]
    @system = params[:s]
    @id = params[:id]
    Octopus.using(:TEMP) do
      if @table == 'dbo.EMPLEADOS'
        @element = Empleado.find(@id)
      end
    end
  end

  def update
    @new = false
    @table = params[:table]
    @id = params[:id]
    element = []
    Octopus.using(:TEMP) do
      sql = "UPDATE dbo.EMPLEADOS SET nombre = '#{params[:nombre]}', curp = '#{params[:curp]}' WHERE id = '#{@id}'" if @table == 'dbo.EMPLEADOS'
      ActiveRecord::Base.connection.execute(sql)
      element << Empleado.find(@id)
    end
    a = Etl.send_to_DWH(element, params[:s])
    if a[0].valid?(params[:s])
      Octopus.using(:TEMP) do
        sql = "DELETE FROM #{@table} WHERE id = #{@id}"
        ActiveRecord::Base.connection.execute(sql)
      end
    end
    if current_user.user_type == 1
      redirect_to etl_index_path
    else
      redirect_to authenticated_root_path
    end
  end
end
