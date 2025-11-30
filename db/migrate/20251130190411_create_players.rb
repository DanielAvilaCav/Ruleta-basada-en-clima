class CreatePlayers < ActiveRecord::Migration[8.1]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :balance, default: 10000

      t.timestamps
    end
  end
end
