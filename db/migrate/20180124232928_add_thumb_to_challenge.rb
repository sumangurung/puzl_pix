class AddThumbToChallenge < ActiveRecord::Migration[5.0]
  def change
    add_column :challenges, :thumb_name, :string, null: true
    add_column :challenges, :thumb_url, :string, null: true
  end
end
