class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :logo
      t.integer :points, default: 0

      t.timestamps
    end
  end
end
