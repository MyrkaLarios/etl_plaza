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
      when 'dbo.TIPO_AREA'
        @element = TipoAreaTEMP.find(@id)
      when 'dbo.AREA'
        @element = AreasTEMP.find(@id)
      when 'dbo.CAJERO'
        @element = CajeroTEMP.find(@id)
      when 'dbo.ESTANCIA_CAJERO'
        @element = EstanciaCajero.find(@id)
      when 'dbo.PASILLO'
        @element = PasilloTEMP.find(@id)
      when 'dbo.SENSOR'
        @element = SensorTEMP.find(@id)
      when 'dbo.HORARIO_DISPONIBLE'
        @element = HorariosDisponiblesTEMP.find(@id)
      when 'dbo.LOCALES'
        @element = LocalTEMP.find(@id)
      when 'dbo.NEGOCIOS'
        @element = NegociosTEMP.find(@id)
      when 'dbo.LOCAL_NEGOCIO'
        @element = LocalNegocioTEMP.find(@id)
      when 'dbo.DESCUENTO'
        @element = DescuentoTEMP.find(@id)
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
