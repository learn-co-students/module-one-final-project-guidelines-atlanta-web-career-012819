class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.integer :rating
      t.integer :show_id
      t.integer :viewer_id
    end
  end
end
