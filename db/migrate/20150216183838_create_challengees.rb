class CreateChallengees < ActiveRecord::Migration
  def change
    create_table :challengees do |t|
      t.string :fb_id
      t.integer :challenge_id
    end
  end
end
