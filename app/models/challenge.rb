class Challenge
  attr_reader :challengees
  def initialize(params)
    @date = params['date']
    @picture_url = params['picture_url']
    @thumb_url = params['thumb_url']
    @game_id = params['game_id']
    @challengees = params['challengees'] || []
  end

  def attributes
    {
      date: @date,
      picture_url: @picture_url,
      thumb_url: @thumb_url,
      challengees: @challengees,
      game_id: @game_id
    }
  end
end
