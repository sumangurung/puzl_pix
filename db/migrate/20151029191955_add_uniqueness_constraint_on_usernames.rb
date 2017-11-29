class AddUniquenessConstraintOnUsernames < ActiveRecord::Migration[5.0]
  def change
    add_index :players, :username, unique: true
  end
end
