module Scores
  class Query
    TIMED_GAME = '0'
    UNTIMED_GAME = '1'

    def initialize(relation, params)
      @relation = relation
      @params = params.dup
    end

    def execute
      relation = apply_user_filter(@relation)
      relation = apply_game_mode_filter(relation)
      relation = apply_game_game_level_filter(relation)
      relation = apply_sort_order(relation)
      relation = apply_filter_scores_older_than_1_week(relation)
      relation = apply_filter_to_filter_out_scores_without_user_record(relation)
      relation = apply_limit(relation)
      relation
    end

    private

    def apply_user_filter(relation)
      unless @params[:user_uuid].blank?
        relation.where(user_uuid: @params[:user_uuid])
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

    def apply_game_game_level_filter(relation)
      level = @params[:game_level]
      unless level.blank?
        relation.where(game_level: level)
      else
        relation
      end
    end

    def apply_sort_order(relation)
      case @params[:game_mode]
      when TIMED_GAME
        relation.order(time: :asc)
      when UNTIMED_GAME
        relation.order(moves: :asc)
      else
        relation
      end
    end

    def apply_filter_scores_older_than_1_week(relation)
      relation.where('date >= ?', 1.week.ago.to_date)
    end

    def apply_limit(relation)
      relation.limit(Rails.configuration.scores_limit)
    end

    def apply_filter_to_filter_out_scores_without_user_record(relation)
      relation.joins(:user).where("users.username IS NOT NULL")
    end
  end
end
