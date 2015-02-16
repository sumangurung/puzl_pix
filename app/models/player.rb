class Player
  def self.create!(params)
    new(params)
  end

  attr_reader :fb_id, :first_name, :last_name, :username

  def initialize(params)
    @fb_id = params['fb_id']
    @first_name = params['first_name']
    @last_name = params['last_name']
    @username = params['username']
  end
end
