class AddScoredGoalsToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :scored_goals, :integer
    add_column :teams, :conceded_goals, :integer
    add_column :teams, :difference_goals, :integer
  end
end
