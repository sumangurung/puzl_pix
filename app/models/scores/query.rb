module Scores
  class Query
    def initialize(relation, params)
      @relation = relation
      @params = params.dup
    end

    def execute
      unless @params[:player_id].blank?
        @relation.where(player_id: @params[:player_id])
      else
        @relation
      end
    end
  end
end
