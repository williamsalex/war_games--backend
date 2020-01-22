class CreatePlayersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :job
      t.string :name
      t.string :image
      t.string :war
      t.string :wins
      t.string :losses
      t.string :era
      t.string :strikeouts
      t.string :ip
      t.string :saves
      t.string :at_bats
      t.string :hits
      t.string :avg
      t.string :hr
      t.string :runs
      t.string :rbi
      t.string :stolen_bases
      t.integer :deck_id
    end
  end
end
