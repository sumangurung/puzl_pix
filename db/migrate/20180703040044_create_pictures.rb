class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
      t.string :image
      t.string :first_name
      t.string :last_name
      t.string :location
      t.boolean :show_attribution, default: false
      t.timestamp :release_datetime
      t.timestamps
    end
  end
end
