class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
    t.integer :amount
    t.integer :donor_id
    t.integer :cause_id
    end
  end
end
