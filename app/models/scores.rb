module Scores
  def self.fetch(params)
    query = Query.new(Persistence::Score.unscoped, params)
    query.execute
  end
end
