class CreateDatabases < ActiveRecord::Migration[5.2]
  def change
    create_table :databases do |t|
      t.string :host
      t.string :adapter
      t.string :mode
      t.string :port
      t.string :password
      t.string :username
      t.string :name
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
