class CreateOutcomes < ActiveRecord::Migration[5.0]
  def change
    create_table :outcomes do |t|
      t.integer :challengee_id, null: false, unique: false
      t.integer :score_id, null: true, unique: true
      t.timestamps
    end

    add_index :outcomes, :challengee_id
    add_index :outcomes, :score_id
    add_index :outcomes, [:challengee_id, :score_id], unique: true
  end
end
