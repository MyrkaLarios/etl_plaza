# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_04_22_233304) do

  create_table "ABONOS", id: :integer, force: :cascade do |t|
    t.date "fechapago"
    t.decimal "saldorestante", precision: 18, scale: 0
    t.decimal "monto", precision: 18, scale: 0
    t.integer "id_renta"
    t.integer "id_ganancia"
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "ACCIDENTES", id: :integer, force: :cascade do |t|
    t.date "fecha"
    t.integer "id_tipoaccidente"
    t.integer "id_empleado"
    t.integer "id_area"
    t.integer "original_id"
    t.char "sistema", limit: 1
  end

  create_table "AREA", id: :integer, force: :cascade do |t|
    t.varchar "nombre", limit: 100
    t.varchar "descripcion", limit: 100
    t.integer "original_id"
    t.integer "id_tipoarea"
    t.char "sistema", limit: 1
  end

  create_table "AREA_HORARIODISPONIBLE", id: :integer, force: :cascade do |t|
    t.integer "id_horariodisponible"
    t.integer "id_area"
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "AREA_SERVICIO", id: :integer, force: :cascade do |t|
    t.integer "periodicidad"
    t.integer "id_servicio"
    t.integer "id_tipoarea"
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "CAJERO", id: :integer, force: :cascade do |t|
    t.integer "dineroactual"
    t.date "fechaactual"
    t.varchar "periodicidadmantenimiento", limit: 15
    t.varchar "estado", limit: 100
    t.integer "id_area"
    t.integer "original_id"
    t.char "sistema", limit: 1
  end

  create_table "CATEGORIA", id: :integer, force: :cascade do |t|
    t.varchar "nombre", limit: 200
    t.integer "original_id"
    t.char "sistema", limit: 1
  end

  create_table "CLIENTE", id: :integer, force: :cascade do |t|
    t.varchar "nombre", limit: 100
    t.varchar "RFC", limit: 100
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "CONTRATANTE", id: :integer, force: :cascade do |t|
    t.varchar "nombre", limit: 100
    t.varchar "direccion", limit: 100
    t.varchar "numero", limit: 100
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "CONTRATO", id: :integer, force: :cascade do |t|
    t.date "fechainicio"
    t.date "fechafin"
    t.money "costo", precision: 19, scale: 4
    t.integer "id_cliente"
    t.integer "id_local"
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "DESCUENTO", id: :integer, force: :cascade do |t|
    t.decimal "cantidad", precision: 18, scale: 0
    t.integer "id_negocio"
    t.integer "id_estancia"
    t.integer "original_id"
    t.char "sistema", limit: 1
  end

  create_table "EGRESO_MANTENIMIENTO", id: :integer, force: :cascade do |t|
    t.integer "cantidad"
    t.date "fecha"
    t.integer "id_ganancia"
    t.integer "original_id"
    t.char "sistema", limit: 1
  end

  create_table "EMPLEADOS", id: :integer, force: :cascade do |t|
    t.varchar "nombre", limit: 100
    t.varchar "curp", limit: 100
    t.integer "id_tipoempleado"
    t.integer "original_id"
    t.char "sistema", limit: 1
  end

  create_table "ESTANCIA", id: :integer, force: :cascade do |t|
    t.date "fechainicio"
    t.date "fechafin"
    t.time "horainicio", precision: 7
    t.time "horafin", precision: 7
    t.integer "duracion"
    t.varchar "estado", limit: 100
    t.money "subtotal", precision: 19, scale: 4
    t.money "total", precision: 19, scale: 4
    t.varchar "placa", limit: 100
    t.integer "id_tarjeta"
    t.integer "original_id"
    t.char "sistema", limit: 1
  end

  create_table "ESTANCIA_CAJERO", id: :integer, force: :cascade do |t|
    t.decimal "tarifa", precision: 18, scale: 0
    t.datetime "fechainicio"
    t.datetime "fechafin"
    t.integer "id_estancia"
    t.integer "original_id"
    t.char "sistema", limit: 1
  end

  create_table "GANANCIAS", id: :integer, force: :cascade do |t|
    t.decimal "ingresos", precision: 18, scale: 0
    t.decimal "egresos", precision: 18, scale: 0
    t.date "fechacorte"
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "HORARIO", id: :integer, force: :cascade do |t|
    t.time "horainicio", precision: 7
    t.time "horafin", precision: 7
    t.date "fechainicio"
    t.date "fechafin"
    t.integer "id_tarea"
    t.integer "id_empleado"
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "HORARIO_DISPONIBLE", id: :integer, force: :cascade do |t|
    t.varchar "horainicio", limit: 20
    t.varchar "horafin", limit: 20
    t.varchar "dia", limit: 100
    t.integer "original_id"
    t.char "sistema", limit: 1
    t.boolean "wrong"
  end

  create_table "INCIDENTE", id: :integer, force: :cascade do |t|
    t.date "fecha"
    t.varchar "clavenotacredito", limit: 100
    t.varchar "clavenotadebito", limit: 100
    t.integer "id_tipoincidente"
    t.char "sistema", limit: 1
    t.integer "id_empleado"
    t.integer "id_recurso_material"
    t.integer "original_id"
  end

  create_table "INGRESO_ESTACIONAMIENTO", id: :integer, force: :cascade do |t|
    t.integer "cantidad"
    t.date "fecha"
    t.integer "id_ganacia"
    t.integer "original_id"
    t.char "sistema", limit: 1
  end

  create_table "LOCALES", id: :integer, force: :cascade do |t|
    t.integer "numero"
    t.varchar "ubicacion", limit: 100
    t.varchar "dimensiones", limit: 100
    t.varchar "estado", limit: 50
    t.money "costo", precision: 19, scale: 4
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "LOCAL_NEGOCIO", id: :integer, force: :cascade do |t|
    t.date "fechainicio"
    t.date "fechafin"
    t.integer "id_negocio"
    t.integer "id_locales"
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "NEGOCIOS", id: :integer, force: :cascade do |t|
    t.varchar "nombre", limit: 100
    t.varchar "giro", limit: 100
    t.char "estado", limit: 1
    t.integer "id_locales"
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "ORDENDESPACHO_MATERIAL", id: :integer, force: :cascade do |t|
    t.integer "cantidadrecibida"
    t.date "fechadecaducidad"
    t.integer "id_recursomaterial"
    t.integer "id_ordendespacho"
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "ORDENSERVICIO_CONTRATANTE", id: :integer, force: :cascade do |t|
    t.money "costo", precision: 19, scale: 4
    t.integer "tiempo"
    t.integer "id_ordenservicio"
    t.integer "id_contratante"
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "ORDENSERVICIO_PERSONA", id: :integer, force: :cascade do |t|
    t.integer "id_ordenservicio"
    t.integer "id_empleado"
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "ORDEN_DESPACHO", id: :integer, force: :cascade do |t|
    t.date "fechaentrega"
    t.integer "id_solicitud"
    t.integer "original_id"
    t.char "sistema", limit: 1
  end

  create_table "ORDEN_SERVICIO", id: :integer, force: :cascade do |t|
    t.date "fecha"
    t.integer "prioridad"
    t.integer "id_tarea"
    t.integer "id_empleado"
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "PAGOS", id: :integer, force: :cascade do |t|
    t.date "fecha"
    t.money "monto", precision: 19, scale: 4
    t.integer "id_empleado"
    t.integer "id_ganancia"
    t.integer "original_id"
    t.char "sistema", limit: 1
  end

  create_table "PASILLO", id: :integer, force: :cascade do |t|
    t.integer "numero"
    t.integer "cantidad_ocupados"
    t.integer "cantidad_libres"
    t.integer "id_area"
    t.integer "original_id"
    t.char "sistema", limit: 1
  end

  create_table "PROVEEDOR", id: :integer, force: :cascade do |t|
    t.varchar "nombre", limit: 100
    t.varchar "rfc", limit: 100
    t.varchar "telefono", limit: 100
    t.varchar "direccion", limit: 100
    t.integer "original_id"
    t.char "sistema", limit: 1
  end

  create_table "PROVEEDOR_MATERIAL", id: :integer, force: :cascade do |t|
    t.money "costo", precision: 19, scale: 4
    t.integer "minimo"
    t.integer "id_recursomaterial"
    t.integer "id_proveedor"
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "RECURSO_MATERIAL", id: :integer, force: :cascade do |t|
    t.varchar "nombre", limit: 100
    t.integer "categoria"
    t.integer "tipo"
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "RENTAS", id: :integer, force: :cascade do |t|
    t.date "fechacobro"
    t.char "statusretraso", limit: 1
    t.char "statuspagado", limit: 1
    t.integer "id_contrato"
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "SECCION_BODEGA", id: :integer, force: :cascade do |t|
    t.varchar "nombre", limit: 100
    t.integer "tamaño"
    t.integer "estante"
    t.integer "numero"
    t.integer "id_recursomaterial"
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "SENSOR", id: :integer, force: :cascade do |t|
    t.varchar "estado", limit: 100
    t.datetime "fecha"
    t.integer "id_pasillo"
    t.integer "original_id"
    t.char "sistema", limit: 1
  end

  create_table "SERVICIO", id: :integer, force: :cascade do |t|
    t.varchar "nombre", limit: 100
    t.integer "duracion"
    t.integer "tipo_servicio"
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "SERVICIO_MATERIAL", id: :integer, force: :cascade do |t|
    t.integer "cantidad"
    t.integer "id_servicio"
    t.integer "recurso_material"
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "SOLICITUD_COMPRA", id: :integer, force: :cascade do |t|
    t.integer "cantidad_total"
    t.date "fechaemision"
    t.money "costototal", precision: 19, scale: 4
    t.integer "id_proveedor"
    t.integer "id_empleado"
    t.integer "original_id"
    t.char "sistema", limit: 1
  end

  create_table "SUPERVISION", id: :integer, force: :cascade do |t|
    t.integer "valoracion"
    t.integer "id_tarea"
    t.integer "id_empleado"
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "TAREA", id: :integer, force: :cascade do |t|
    t.integer "duracion"
    t.integer "id_servicio"
    t.integer "id_area"
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "TAREA_MATERIAL", id: :integer, force: :cascade do |t|
    t.integer "cantidadentregada"
    t.integer "id_tarea"
    t.integer "id_recursomaterial"
    t.integer "id_empleado"
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "TARJETA", id: :integer, force: :cascade do |t|
    t.varchar "estado", limit: 100
    t.integer "original_id"
    t.char "sistema", limit: 1
  end

  create_table "TIPO_ACCIDENTE", id: :integer, force: :cascade do |t|
    t.varchar "nombre", limit: 100
    t.integer "original_id"
    t.char "sistema", limit: 1
  end

  create_table "TIPO_AREA", id: :integer, force: :cascade do |t|
    t.varchar "nombre", limit: 100
    t.integer "original_id"
    t.char "sistema", limit: 1
  end

  create_table "TIPO_EMPLEADOS", id: :integer, force: :cascade do |t|
    t.varchar "nombre", limit: 100
    t.money "salario", precision: 19, scale: 4
    t.integer "original_id"
    t.char "sistema", limit: 1
  end

  create_table "TIPO_INCIDENTE", id: :integer, force: :cascade do |t|
    t.varchar "nombre", limit: 100
    t.varchar "descripcion", limit: 100
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "TIPO_MATERIAL", id: :integer, force: :cascade do |t|
    t.varchar "nombre", limit: 200
    t.char "sistema", limit: 1
    t.integer "original_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "databases", force: :cascade do |t|
    t.string "host"
    t.string "adapter"
    t.string "mode"
    t.string "port"
    t.string "password"
    t.string "username"
    t.string "name"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_databases_on_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "user_type", default: 3, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "databases", "companies"
end
