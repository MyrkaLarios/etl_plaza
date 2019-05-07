class EtlController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    if Empleado.all.empty?
      Etl.start
      # redirect_to etl_index_path
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
      case @table
      when 'dbo.EMPLEADOS'
        @element = Empleado.find(@id)
      when 'dbo.TIPO_EMPLEADOS'
        @element = TipoEmpleado.find(@id)
      when 'dbo.RECURSO_MATERIAL'
        @element = RecursoMaterial.find(@id)
      when 'dbo.TARJETA'
        @element = TarjetasTEMP.find(@id)
      when 'dbo.ESTANCIA'
        @element = EstanciaTEMP.find(@id)
      end
    end
  end


  def update
    Octopus.using(:TEMP) do
      UpdateTemp.update_object(params)
    end
    if current_user.user_type == 1
      redirect_to etl_index_path
    else
      redirect_to authenticated_root_path
    end
  end
end
