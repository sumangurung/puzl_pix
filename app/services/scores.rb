require 'scores/query'

module Scores
  def self.fetch(params)
    query = Query.new(Score.unscoped, params)
    query.execute
  end
end
