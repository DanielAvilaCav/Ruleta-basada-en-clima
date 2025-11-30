class CreateRounds < ActiveRecord::Migration[8.1]
  def change
    create_table :rounds do |t|
      t.references :player, null: false, foreign_key: true
      t.string :bet_color
      t.integer :bet_amount
      t.string :wheel_result
      t.string :result
      t.integer :player_winnings
      t.string :weather_condition
      t.decimal :weather_temp
      t.string :weather_description

      t.timestamps
    end
  end
end
