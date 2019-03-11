class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.references :team_home, foreign_key: {to_table: :teams}
      t.references :team_away, foreign_key: {to_table: :teams}
      t.integer :score_home
      t.integer :score_away
      t.float :odds_home
      t.float :odds_away
      t.datetime :start_time
      t.status :string
      t.matchday :integer

      t.timestamps
    end
  end
end
