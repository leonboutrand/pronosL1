class CreateBets < ActiveRecord::Migration[5.2]
  def change
    create_table :bets do |t|
      t.references :game, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :score_home
      t.integer :score_away
      t.integer :points
      t.float :points_odds

      t.timestamps
    end
  end
end
