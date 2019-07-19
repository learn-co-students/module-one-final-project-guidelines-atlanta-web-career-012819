class CreateViewers < ActiveRecord::Migration[5.0]
  def change
    create_table :viewers do |t|
      t.string :name
      t.string :country
    end
  end
end
