class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :war
      t.string :image
      t.integer :deck_id
      t.timestamps
    end
  end
end
