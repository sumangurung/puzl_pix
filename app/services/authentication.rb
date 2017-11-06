module Authentication
  def self.create_new_api_key
    ApiKey.create(token: generate_random_token).token
  end

  def self.valid_key?(token)
    ApiKey.exists?(token: token)
  end

  def self.generate_random_token
    loop do
      token = SecureRandom.base64.tr('+/=', 'Qrt')
      break token if key_is_fresh?(token)
    end
  end
  private_class_method :generate_random_token

  def self.key_is_fresh?(token)
    !ApiKey.exists?(token: token)
  end
  private_class_method :key_is_fresh?
end
