class AddPlayedGamesToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :played_games, :integer
  end
end
