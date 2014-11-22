class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :number
      t.string :title
      t.text :body
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
