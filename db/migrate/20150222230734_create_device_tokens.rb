class CreateDeviceTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :device_tokens do |t|
      t.string :token
      t.string :fb_id
      t.timestamps
    end
  end
end
