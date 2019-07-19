class CreateShows < ActiveRecord::Migration[5.0]
  def change
    create_table :shows do |t|
      t.string :title
      t.string :network
      t.string :country
      t.text :summary
    end
  end
end
