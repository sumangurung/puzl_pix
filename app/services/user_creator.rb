class UserCreator
  def self.create(user_params)
    instantiate_and_return_user(user_params) do |user|
      user.save
    end
  end

  def self.create!(user_params)
    instantiate_and_return_user(user_params) do |user|
      user.save!
    end
  end

  def self.instantiate_and_return_user(user_params)
    user = User.new(user_params)
    if user.username.blank?
      user.username = "User #{Time.now.to_i}"
    end

    yield(user)

    user
  end
end
