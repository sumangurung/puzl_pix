class CreateChallengees < ActiveRecord::Migration[5.0]
  def change
    create_table :challengees do |t|
      t.string :fb_id
      t.integer :challenge_id

      t.timestamps
    end
  end
end
