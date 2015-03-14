module Scores
  class Query
    def initialize(relation, params)
      @relation = relation
      @params = params.dup
    end

    def execute
      relation = apply_player_filter(@relation)
      relation = apply_game_mode_filter(relation)
      relation = apply_game_difficulty_filter(relation)
      relation
    end

    private

    def apply_player_filter(relation)
      unless @params[:player_id].blank?
        relation.where(player_id: @params[:player_id])
      else
        relation
      end
    end

    def apply_game_mode_filter(relation)
      unless @params[:game_mode].blank?
        relation.where(game_mode: @params[:game_mode])
      else
        relation
      end
    end

    def apply_game_difficulty_filter(relation)
      unless @params[:difficulty].blank?
        relation.where(difficulty: @params[:difficulty])
      else
        relation
      end
    end
  end
end
