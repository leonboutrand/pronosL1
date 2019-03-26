class AddClosedToBets < ActiveRecord::Migration[5.2]
  def change
    add_column :bets, :closed, :boolean, default: false
  end
end
